note
	description: "Concrete version of an external iteration cursor for {INDEXABLE}."
	library: "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	INDEXABLE_ITERATION_CURSOR [G]

inherit
	ITERATION_CURSOR [G]

	ITERABLE [G]

create
	make

feature {NONE} -- Initialization

	make (s: like target)
			-- Initialize cursor using structure `s'.
		require
			s_attached: s /= Void
		do
			target := s
			if attached {VERSIONABLE} s as l_versionable then
				version := l_versionable.version
			else
				version := 0
			end
			step := 1
			is_reversed := False
		ensure
			structure_set: target = s
			is_valid: is_valid
			default_step: step = 1
			ascending_traversal: not is_reversed
		end

feature -- Access

	item: G
			-- <Precursor>
		do
			Result := target.item (target_index)
		end

	cursor_index: INTEGER
			-- Index position of cursor in the iteration.
		require
			is_valid: is_valid
		do
				-- Take next index position if `target_index' is not in sync with step,
				-- as the latter may happen when going `after' the end of the `target'.
			if is_reversed then
				Result := (index_set.upper - target_index + step - 1) // step + 1
			else
				Result := (target_index - index_set.lower + step - 1) // step + 1
			end
		ensure
			positive_index: Result >= 0
		end

	target_index: INTEGER
			-- Index position of `target' for current iteration.

	step: INTEGER
			-- Distance between successive iteration elements.

	new_cursor: INDEXABLE_ITERATION_CURSOR [G]
			-- Restarted copy of Current.
		do
			Result := twin
			Result.start
		end

	reversed alias "-": like Current
			-- Reversed copy of Current.
		do
			Result := twin
			Result.reverse
		ensure
			is_reversed: Result.is_reversed = not is_reversed
			same_structure: Result.target = target
			same_step: Result.step = step
		end

	incremented alias "+" (n: like step): like Current
			-- Copy of Current with step increased by `n'.
		require
			n_valid: step + n > 0
		do
			Result := twin
			Result.set_step (step + n)
		ensure
			is_incremented: Result.step = step + n
			same_structure: Result.target = target
			same_direction: Result.is_reversed = is_reversed
		end

	decremented alias "-" (n: like step): like Current
			-- Copy of Current with step decreased by `n'.
		require
			n_valid: step > n
		do
			Result := twin
			Result.set_step (step - n)
		ensure
			is_incremented: Result.step = step - n
			same_structure: Result.target = target
			same_direction: Result.is_reversed = is_reversed
		end

	with_step (n: like step): like Current
			-- Copy of Current with step set to `n'.
		require
			n_positive: n > 0
		do
			Result := twin
			Result.set_step (n)
		ensure
			step_set: Result.step = n
			same_structure: Result.target = target
			same_direction: Result.is_reversed = is_reversed
		end

feature -- Measurement

	version: NATURAL
			-- Current version.
		note
			option: transient
		attribute
		end

feature -- Status report

	after: BOOLEAN
			-- <Precursor>
		do
			Result := not is_valid or not target.valid_index (target_index)
		end

	is_reversed: BOOLEAN
			-- Are we traversing `target' backwards?

	is_valid: BOOLEAN
			-- Is the cursor still compatible with the associated underlying object?
		do
			Result := attached {VERSIONABLE} target as l_versionable implies l_versionable.version = version
		end

feature -- Status setting

	reverse
			-- Flip traversal order.
		do
			is_reversed := not is_reversed
		ensure
			is_reversed: is_reversed = not old is_reversed
		end

	set_step (v: like step)
			-- Set increment step to `v'.
		require
			v_positive: v > 0
		do
			step := v
		ensure
			step_set: step = v
		end

feature -- Cursor movement

	start
			-- Move to first position.
		do
			if is_reversed then
				target_index := index_set.upper
			else
				target_index := index_set.lower
			end
		ensure
			cursor_index_set_to_one: cursor_index = 1
		end

	forth
			-- <Precursor>
		do
			if is_reversed then
				target_index := target_index - step
			else
				target_index := target_index + step
			end
		ensure then
			cursor_index_advanced: cursor_index = old cursor_index + 1
		end

feature {ITERABLE, ITERATION_CURSOR} -- Implementation

	target: READABLE_INDEXABLE [G]
			-- Associated structure used for iteration.

	index_set: INTEGER_INTERVAL
			-- Range of acceptable indexes for `target'.
		do
			Result := target.index_set
		end

invariant
	target_attached: target /= Void
	step_positive: step > 0

end
