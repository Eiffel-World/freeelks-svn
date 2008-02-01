indexing
	description: "[
		Exception manager. 
		The manager handles all common operations of exception mechanism and interaction with the ISE runtime.
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	EXCEPTION_MANAGER

feature -- Access

	last_exception: EXCEPTION
			-- Last exception
		do
			Result := last_exception_cell.item
		end

	type_of_code (a_code: INTEGER): TYPE [EXCEPTION]
			-- Exception type of `a_code'
		do
			inspect a_code
			when {EXCEP_CONST}.void_call_target then
				Result := {VOID_TARGET}
			when {EXCEP_CONST}.No_more_memory then
				Result := {NO_MORE_MEMORY}
			when {EXCEP_CONST}.Precondition then
				Result := {PRECONDITION_VIOLATION}
			when {EXCEP_CONST}.Postcondition then
				Result := {POSTCONDITION_VIOLATION}
			when {EXCEP_CONST}.Floating_point_exception then
				Result := {FLOATING_POINT_FAILURE}
			when {EXCEP_CONST}.Class_invariant then
				Result := {INVARIANT_VIOLATION}
			when {EXCEP_CONST}.Check_instruction then
				Result := {CHECK_VIOLATION}
			when {EXCEP_CONST}.Routine_failure then
				Result := {ROUTINE_FAILURE}
			when {EXCEP_CONST}.Incorrect_inspect_value then
				Result := {BAD_INSPECT_VALUE}
			when {EXCEP_CONST}.Loop_variant then
				Result := {VARIANT_VIOLATION}
			when {EXCEP_CONST}.Loop_invariant then
				Result := {LOOP_INVARIANT_VIOLATION}
			when {EXCEP_CONST}.Signal_exception then
				Result := {OPERATING_SYSTEM_SIGNAL_FAILURE}
			when {EXCEP_CONST}.Eiffel_runtime_panic then
				Result := {EIFFEL_RUNTIME_PANIC}
			when {EXCEP_CONST}.Rescue_exception then
					-- Obselete
				Result := {RESCUE_FAILURE}
			when {EXCEP_CONST}.Out_of_memory then
					-- Should have difference with `No_more_memory'
				Result := {NO_MORE_MEMORY}
			when {EXCEP_CONST}.Resumption_failed then
					-- Obselete
				Result := {RESUMPTION_FAILURE}
			when {EXCEP_CONST}.Create_on_deferred then
				Result := {CREATE_ON_DEFERRED}
			when {EXCEP_CONST}.External_exception then
				Result := {EXTERNAL_FAILURE}
			when {EXCEP_CONST}.Void_assigned_to_expanded then
				Result := {VOID_ASSIGNED_TO_EXPANDED}
			when {EXCEP_CONST}.Exception_in_signal_handler then
					-- Obselete
				Result := {EXCEPTION_IN_SIGNAL_HANDLER_FAILURE}
			when {EXCEP_CONST}.Io_exception then
				Result := {IO_FAILURE}
			when {EXCEP_CONST}.Operating_system_exception then
				Result := {OPERATING_SYSTEM_FAILURE}
			when {EXCEP_CONST}.Retrieve_exception then
				Result := {MISMATCH_FAILURE}
			when {EXCEP_CONST}.Developer_exception then
				Result := {DEVELOPER_EXCEPTION}
			when {EXCEP_CONST}.Eiffel_runtime_fatal_error then
				Result := {EIFFEL_RUNTIME_PANIC}
			when {EXCEP_CONST}.Dollar_applied_to_melted_feature then
				Result := {ADDRESS_APPLIED_TO_MELTED_FEATURE}
			when {EXCEP_CONST}.Runtime_io_exception then
				Result := {IO_FAILURE}
			when {EXCEP_CONST}.Com_exception then
				Result := {COM_FAILURE}
			when {EXCEP_CONST}.Runtime_check_exception then
				Result := {CHECK_VIOLATION}
			when {EXCEP_CONST}.old_exception then
				Result := {OLD_VIOLATION}
			when {EXCEP_CONST}.serialization_exception then
				Result := {SERIALIZATION_FAILURE}
			else
				Result := Void
			end
		end

	exception_from_code (a_code: INTEGER): EXCEPTION is
			-- Create exception object from `a_code'
		do
			inspect a_code
			when {EXCEP_CONST}.void_call_target then
				create {VOID_TARGET}Result
			when {EXCEP_CONST}.No_more_memory then
				Result := no_memory_exception_object_cell.item
			when {EXCEP_CONST}.Precondition then
				create {PRECONDITION_VIOLATION}Result
			when {EXCEP_CONST}.Postcondition then
				create {POSTCONDITION_VIOLATION}Result
			when {EXCEP_CONST}.Floating_point_exception then
				create {FLOATING_POINT_FAILURE}Result
			when {EXCEP_CONST}.Class_invariant then
				create {INVARIANT_VIOLATION}Result
			when {EXCEP_CONST}.Check_instruction then
				create {CHECK_VIOLATION}Result
			when {EXCEP_CONST}.Routine_failure then
				create {ROUTINE_FAILURE}Result
			when {EXCEP_CONST}.Incorrect_inspect_value then
				create {BAD_INSPECT_VALUE}Result
			when {EXCEP_CONST}.Loop_variant then
				create {VARIANT_VIOLATION}Result
			when {EXCEP_CONST}.Loop_invariant then
				create {LOOP_INVARIANT_VIOLATION}Result
			when {EXCEP_CONST}.Signal_exception then
				create {OPERATING_SYSTEM_SIGNAL_FAILURE}Result
			when {EXCEP_CONST}.Eiffel_runtime_panic then
				create {EIFFEL_RUNTIME_PANIC}Result
			when {EXCEP_CONST}.Rescue_exception then
					-- Obselete
				create {RESCUE_FAILURE}Result
			when {EXCEP_CONST}.Out_of_memory then
					-- Should have difference with `No_more_memory'
				Result := no_memory_exception_object_cell.item
			when {EXCEP_CONST}.Resumption_failed then
					-- Obselete
				create {RESUMPTION_FAILURE}Result
			when {EXCEP_CONST}.Create_on_deferred then
				create {CREATE_ON_DEFERRED}Result
			when {EXCEP_CONST}.External_exception then
				create {EXTERNAL_FAILURE}Result
			when {EXCEP_CONST}.Void_assigned_to_expanded then
				create {VOID_ASSIGNED_TO_EXPANDED}Result
			when {EXCEP_CONST}.Exception_in_signal_handler then
					-- Obselete
				create {EXCEPTION_IN_SIGNAL_HANDLER_FAILURE}Result
			when {EXCEP_CONST}.Io_exception then
				create {IO_FAILURE}Result
			when {EXCEP_CONST}.Operating_system_exception then
				create {OPERATING_SYSTEM_FAILURE}Result
			when {EXCEP_CONST}.Retrieve_exception then
				create {MISMATCH_FAILURE}Result
			when {EXCEP_CONST}.Developer_exception then
				create {DEVELOPER_EXCEPTION}Result
			when {EXCEP_CONST}.Eiffel_runtime_fatal_error then
					-- Should be different from `Eiffel_runtime_panic'
				create {EIFFEL_RUNTIME_PANIC}Result
			when {EXCEP_CONST}.Dollar_applied_to_melted_feature then
				create {ADDRESS_APPLIED_TO_MELTED_FEATURE}Result
			when {EXCEP_CONST}.Runtime_io_exception then
				create {IO_FAILURE}Result
			when {EXCEP_CONST}.Com_exception then
				create {COM_FAILURE}Result
			when {EXCEP_CONST}.Runtime_check_exception then
				create {CHECK_VIOLATION}Result
			when {EXCEP_CONST}.old_exception then
				create {OLD_VIOLATION}Result
			when {EXCEP_CONST}.serialization_exception then
				create {SERIALIZATION_FAILURE}Result
			else
			end
		end

feature -- Raise

	raise (a_exception: EXCEPTION) is
			-- Raise `a_exception'.
			-- Raising `a_exception' by this routine makes `a_exception' accessable by `last_exception'
			-- in rescue clause. Hence causes removal of original `last_exception'.
			-- If the original `last_exception' needs to be reserved, `set_throwing_exception'
			-- on `a_exception' can be called.
		require
			a_exception_not_void: a_exception /= Void
			a_exception_is_raisable: a_exception.is_raisable
		local
			c_meaning, c_message: ANY
		do
			if not a_exception.is_ignored then
				set_last_exception (a_exception)
				if a_exception.meaning /= Void then
					c_meaning := a_exception.meaning.to_c
				else
					c_meaning := ("").to_c
				end
				if a_exception.message /= Void then
					c_message := a_exception.message.to_c
				else
					c_message := ("").to_c
				end
				developer_raise (a_exception.code, $c_meaning, $c_message)
			end
		end

feature -- Status setting

	ignore (a_exception: TYPE [EXCEPTION]) is
			-- Make sure that any exception of code `code' will be
			-- ignored. This is not the default.
		require
			a_exception_not_void: a_exception /= Void
			is_ignorable: is_ignorable (a_exception)
		do
			ignored_exceptions.extend (a_exception)
		ensure
			is_caught: is_ignored (a_exception)
		end

	catch (a_exception: TYPE [EXCEPTION]) is
			-- Set type of `a_exception' `is_ignored'.
		require
			a_exception_not_void: a_exception /= Void
		do
			ignored_exceptions.prune_all (a_exception)
		ensure
			is_ignored: not is_ignored (a_exception)
		end

	set_is_ignored (a_exception: TYPE [EXCEPTION]; a_ignored: BOOLEAN) is
			-- Set type of `a_exception' to be `a_ignored'.
		require
			a_exception_not_void: a_exception /= Void
			a_ignored_implies_is_ignorable: a_ignored implies is_ignorable (a_exception)
		do
			if a_ignored then
				ignore (a_exception)
			else
				catch (a_exception)
			end
		ensure
			is_ignored_set: is_ignored (a_exception) = a_ignored
		end

feature -- Status report

	is_ignorable (a_exception: TYPE [EXCEPTION]): BOOLEAN is
			-- If set, type of `a_exception' is ignorable.
		do
			Result := not unignorable_exceptions.has (a_exception)
		end

	is_raisable (a_exception: TYPE [EXCEPTION]): BOOLEAN is
			-- If set, type of `a_exception' is raisable.
		do
			Result := not unraisable_exceptions.has (a_exception)
		end

	is_ignored (a_exception: TYPE [EXCEPTION]): BOOLEAN is
			-- If set, type of `a_exception' is not raised.
		do
			Result := ignored_exceptions.has (a_exception)
		ensure
			not_is_caught: Result = not is_caught (a_exception)
		end

	is_caught (a_exception: TYPE [EXCEPTION]): BOOLEAN is
			-- If set, type of `a_exception' is raised.
		do
			Result := not ignored_exceptions.has (a_exception)
		ensure
			not_is_ignored: Result = not is_ignored (a_exception)
		end

feature {NONE} -- Access

	exception_data: TUPLE [code: INTEGER; signal_code: INTEGER; error_code: INTEGER; tag, recipient, eclass: STRING; rf_routine, rf_class: STRING; trace: STRING; line_number: INTEGER; is_invariant_entry: BOOLEAN] is
			-- Exception data
			-- Used to store temporary exception information,
			-- which is used to create exception object later.
		do
			Result := exception_data_cell.item
		end

feature {NONE} -- Element change

	set_last_exception (a_last_exception: EXCEPTION) is
			-- Set `last_exception' with `a_last_exception'.
		do
			last_exception_cell.put (a_last_exception)
		ensure
			last_exception_set: last_exception_cell.item = a_last_exception
		end

	set_exception_data (code: INTEGER; new_obj: BOOLEAN; signal_code: INTEGER; error_code: INTEGER; tag, recipient, eclass: STRING;
						rf_routine, rf_class: STRING; trace: STRING; line_number: INTEGER; is_invariant_entry: BOOLEAN) is
			-- Set exception data.
			-- When a stack overflow exception is caught, this is a critical session.
			-- Big memory allocation will fail.
		local
			l_exception: EXCEPTION
		do
			exception_data_cell.put ([code, signal_code, error_code, tag, recipient, eclass, rf_routine, rf_class, trace, line_number, is_invariant_entry])
			if new_obj then
				l_exception := exception_from_data
				if l_exception /= Void then
					set_last_exception (l_exception)
				end
			else
					-- This exception was raised from Eiffel code.
					-- Now the callback from runtime simple fill the exception object with interesting information.
				l_exception := last_exception
				check
					last_exception_not_void: l_exception /= Void
				end
				l_exception.set_exception_trace (trace)
				l_exception.set_recipient_name (recipient)
				l_exception.set_type_name (eclass)
			end
		end

feature {NONE} -- Implementation, ignoring

	ignored_exceptions: ARRAYED_SET [TYPE [EXCEPTION]] is
			-- Ignored exceptions
		once
			create Result.make (0)
			Result.compare_objects
		end

	unignorable_exceptions: ARRAYED_SET [TYPE [EXCEPTION]] is
			-- Unignorable exceptions
		once
			create Result.make (1)
			Result.compare_objects
			Result.extend ({VOID_TARGET})
		end

	unraisable_exceptions: ARRAYED_SET [TYPE [EXCEPTION]] is
			-- Unraisable exceptions
		once
			create Result.make (0)
			Result.compare_objects
		end

feature {NONE} -- Implementation

	is_code_ignored (a_code: INTEGER): BOOLEAN is
			-- Is exception of `a_code' ignored?
		local
			l_type: TYPE [EXCEPTION]
		do
			l_type := type_of_code (a_code)
			if l_type /= Void then
				Result := is_ignored (l_type)
			else
				Result := True
			end
		end

feature {NONE} -- Cells

	exception_data_cell: CELL [TUPLE [code: INTEGER; signal_code: INTEGER; error_code: INTEGER; tag, recipient, eclass: STRING; rf_routine, rf_class: STRING; trace: STRING; line_number: INTEGER; is_invariant_entry: BOOLEAN]] is
			-- Cell to hold current exception data
		once
			create Result
		end

	last_exception_cell: CELL [EXCEPTION] is
			-- Cell to hold last exception
		once
			create Result
		end

feature {NONE} -- Implementation

	exception_from_data: EXCEPTION is
			-- Create an exception object `exception_data'
		local
			l_data: like exception_data
			l_rf: ROUTINE_FAILURE
			l_ov: OLD_VIOLATION
			l_inva: INVARIANT_VIOLATION
			l_sig: OPERATING_SYSTEM_SIGNAL_FAILURE
			l_io: IO_FAILURE
			l_sys: OPERATING_SYSTEM_FAILURE
			l_com: COM_FAILURE
		do
			l_data := exception_data
			if l_data /= Void then
				Result := exception_from_code (l_data.code)
				l_rf ?= Result
				if l_rf /= Void then
					Result.set_throwing_exception (last_exception)
					l_rf.set_routine_name (l_data.rf_routine)
					l_rf.set_class_name (l_data.rf_class)
				else
					l_ov ?= Result
					if l_ov /= Void then
						Result.set_throwing_exception (last_exception)
					else
						l_inva ?= Result
						if l_inva /= Void then
							l_inva.set_is_entry (l_data.is_invariant_entry)
						else
							l_sig ?= Result
							if l_sig /= Void then
								l_sig.set_signal_code (l_data.signal_code)
							else
								l_io ?= Result
								if l_io /= Void then
									l_io.set_error_code (l_data.error_code)
								else
									l_sys ?= Result
									if l_sys /= Void then
										l_sys.set_error_code (l_data.error_code)
									else
										l_com ?= Result
										if l_com /= Void then
											l_com.set_hresult_code (l_data.signal_code)
											l_com.set_exception_information (l_data.tag)
										end
									end
								end
							end

						end
						Result.set_throwing_exception (Result)
					end
				end
				Result.set_exception_trace (l_data.trace)
				Result.set_message (l_data.tag)
				Result.set_recipient_name (l_data.recipient)
				Result.set_type_name (l_data.eclass)
			end
		end

	internal_object: INTERNAL
		once
			create Result
		end

	once_raise (a_exception: EXCEPTION) is
			-- Called by runtime to raise saved exception for once routines.
		local
			c_meaning, c_message: ANY
		do
			if not a_exception.is_ignored then
				set_last_exception (a_exception)
				if a_exception.meaning /= Void then
					c_meaning := a_exception.meaning.to_c
				else
					c_meaning := ("").to_c
				end
				if a_exception.message /= Void then
					c_message := a_exception.message.to_c
				else
					c_message := ("").to_c
				end
				developer_raise (a_exception.code, $c_meaning, $c_message)
			end
		end

	no_memory_exception_object_cell: CELL [NO_MORE_MEMORY] is
			-- No more memory exception object.
		once
			create Result
		end

	frozen init_exception_manager is
			-- Call once routines to create objects beforehand,
			-- in case it goes into critical session (Stack overflow, no memory etc.)
			-- The creations doesn't fail.
		local
			arr: like ignored_exceptions
			l_data: like exception_data_cell
			l_ex: like last_exception_cell
			inte: like internal_object
			l_nomem: NO_MORE_MEMORY
		do
			arr := ignored_exceptions
			arr := unignorable_exceptions
			arr := unraisable_exceptions
			l_data := exception_data_cell
			l_ex := last_exception_cell
			inte := internal_object
				-- Reserve memory for no more memory exception object.
			create l_nomem
			l_nomem.set_exception_trace (create {STRING_8}.make (4096))
			no_memory_exception_object_cell.put (l_nomem)
		end

	frozen free_preallocated_trace is
		do
			no_memory_exception_object_cell.item.set_message (Void)
		end

	developer_raise (a_code: INTEGER; a_meaning, a_message: POINTER) is
			-- Raise an exception
		external
			"built_in"
		end

end