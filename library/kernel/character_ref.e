indexing
	description: "References to objects containing a character value"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2004, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class CHARACTER_REF inherit

	COMPARABLE
		redefine
			out, is_equal
		end

	HASHABLE
		redefine
			is_hashable, out, is_equal
		end

feature -- Access

	item: CHARACTER
			-- Character value

	code: INTEGER is
			-- Associated integer value
		do
			Result := chcode (item)
		end

	hash_code: INTEGER is
			-- Hash code value
		do
			Result := code
		end

	Min_value: INTEGER is 0
	Max_value: INTEGER is 255
			-- Bounds for integer representation of characters (ASCII)

feature -- Status report

	is_hashable: BOOLEAN is
			-- May current object be hashed?
			-- (True if it is not its type's default.)
		do
			Result := item /= '%U'
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is `other' greater than current character?
		do
			Result := item < other.item
		ensure then
			definition: Result = (code < other.code)
		end

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object of the same type
			-- as current object and identical to it?
		do
			Result := other.item = item
		end

feature -- Basic routines

	infix "+" (incr: INTEGER): CHARACTER is
			-- Add `incr' to the code of `item'
		require
			valid_increment: (item.code + incr).is_valid_character_code
		do
			Result := chconv (chcode (item) + incr)
		ensure
			valid_result: Result |-| item = incr
		end

	infix "-" (decr: INTEGER): CHARACTER is
			-- Subtract `decr' to the code of `item'
		require
			valid_decrement: (item.code - decr).is_valid_character_code
		do
			Result := chconv (chcode (item) - decr)
		ensure
			valid_result: item |-| Result = decr
		end

	infix "|-|" (other: CHARACTER): INTEGER is
			-- Difference between the codes of `item' and `other'
		do
			Result := chcode (item) - chcode (other)
		ensure
			valid_result: other + Result = item
		end

	next: CHARACTER is
			-- Next character
		require
			valid_character: (item.code + 1).is_valid_character_code
		do
			Result := item + 1
		ensure
			valid_result: Result |-| item = 1
		end

	previous: CHARACTER is
			-- Previous character
		require
			valid_character: (item.code - 1).is_valid_character_code
		do
			Result := item - 1
		ensure
			valid_result: Result |-| item = -1
		end

feature -- Element change

	set_item (c: CHARACTER) is
			-- Make `c' the `item' value.
		do
			item := c
		end

feature -- Output

	out: STRING is
			-- Printable representation of character
		do
			Result := c_outc (item)
		end

feature {NONE} -- Initialization

	make_from_reference (v: CHARACTER_REF) is
			-- Initialize `Current' with `v.item'.
		require
			v_not_void: V /= Void
		do
			item := v.item
		ensure
			item_set: item = v.item	
		end

feature -- Conversion

	to_reference: CHARACTER_REF is
			-- Associated reference of Current
		do
			create Result
			Result.set_item (item)
		ensure
			to_reference_not_void: Result /= Void
		end

	as_upper, upper: CHARACTER is
			-- Uppercase value of `item'
			-- Returns `item' if not `is_lower'
		do
			Result := chupper (item)
		end

	as_lower, lower: CHARACTER is
			-- Lowercase value of `item'
			-- Returns `item' if not `is_upper'
		do
			Result := chlower (item)
		end

feature -- Status report

	is_lower: BOOLEAN is
			-- Is `item' lowercase?
		do
			Result := chis_lower (item)
		end

	is_upper: BOOLEAN is
			-- Is `item' uppercase?
		do
			Result := chis_upper (item)
		end

	is_digit: BOOLEAN is
			-- Is `item' a digit?
			-- A digit is one of 0123456789
		do
			Result := chis_digit (item)
		end

	is_alpha: BOOLEAN is
			-- Is `item' alphabetic?
			-- Alphabetic is `is_upper' or `is_lower'
		do
			Result := chis_alpha (item)
		end

feature {NONE} -- Implementation

	chcode (c: like item): INTEGER is
			-- Associated integer value
		external
			"built_in"
		end

	chconv (i: INTEGER): CHARACTER is
			-- Character associated with integer value `i'
		external
			"built_in"
		end

	c_outc (c: CHARACTER): STRING is
			-- Printable representation of character
		external
			"built_in"
		end

	chupper (c: CHARACTER): CHARACTER is
		external
			"built_in"
		end

	chlower (c: CHARACTER): CHARACTER is
		external
			"built_in"
		end

	chis_lower (c: CHARACTER): BOOLEAN is
		external
			"built_in"
		end

	chis_upper (c: CHARACTER): BOOLEAN is
		external
			"built_in"
		end

	chis_digit (c: CHARACTER): BOOLEAN is
		external
			"built_in"
		end

	chis_alpha (c: CHARACTER): BOOLEAN is
		external
			"built_in"
		end

end -- class CHARACTER_REF
