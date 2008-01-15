indexing
	description: "[
		Exception for a COM error
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	COM_FAILURE

inherit
	OPERATING_SYSTEM_EXCEPTION

feature -- Access

	hresult: INTEGER
			-- Original HRESULT.

	hresult_code: INTEGER
			-- Error code of COM

	code: INTEGER is
			-- Exception code
		once
			Result := {EXCEP_CONST}.com_exception
		end

feature -- Status setting

	set_hresult_code(a_code: like hresult_code) is
			-- Set `hresult_code' with `a_code'.
		do
			hresult_code := a_code
		end

	hresult_facility: INTEGER is
			-- Facility code.
		do
			Result := ccom_hresult_facility (hresult)
		end

	hresult_message: STRING is
			-- Error message.
		do
			Result := exception_information.twin
			Result.remove_head (10)
			Result.left_adjust
			Result.right_adjust

			if Result.is_empty and then hresult_code > 0 then
				Result := error_message (hresult_code).out
			end
			if Result = Void then
				create Result.make (0)
			end
		ensure
			non_void_message: Result /= Void
		end

feature -- Element Change

	trigger (a_code: INTEGER) is
			-- Raise exception with code `code'.
			-- See class ECOM_EXCEPTION_CODES in EiffelCom for possible values.
		local
			l_hresult_string: STRING
		do
			hresult_code := a_code
			l_hresult_string := ccom_hresult_to_string (a_code)
			set_message (l_hresult_string)
			set_exception_information (l_hresult_string)
			raise
		end

feature {EXCEPTION_MANAGER} -- Implementation

	exception_information: STRING
			-- Stream holding exception information.

	set_exception_information(a_message: STRING) is
			-- Initialize current with stream of `a_message'.
		require
			a_message_not_void: a_message /= Void
		local
			c_string: C_STRING
		do
			exception_information := a_message
			if hresult_code > 0 then
					-- Error code has been set, simply use it.
				create c_string.make (ccom_hresult_to_string (hresult_code))
				hresult := ccom_hresult (c_string.item)
			else
					-- Error code is not set, extract from `a_message'
				create c_string.make (a_message)
				hresult := ccom_hresult (c_string.item)
				hresult_code := ccom_hresult_code (hresult)
			end
		end

feature {NONE} -- Implementation

	frozen ccom_hresult_to_string (a_code: INTEGER): STRING is
		do
			Result := a_code.to_hex_string
			Result := "0x" + Result
		end

	frozen ccom_hresult (an_exception_code: POINTER): INTEGER is
		external
			"built_in"
		end

	frozen ccom_hresult_code (an_hresult: INTEGER): INTEGER is
		external
			"built_in"
		end

	frozen ccom_hresult_facility (an_hresult: INTEGER): INTEGER is
		external
			"built_in"
		end

	frozen cwin_error_text (a_code: INTEGER): POINTER is
			-- Get text from error `a_code'. It is up to the caller to free
			-- the returned buffer using `cwin_local_free'.
		external
			"built_in"
		end

	frozen c_strlen (ptr: POINTER): INTEGER_32
			-- Number of characters in `ptr'.
			-- (export status {NONE})
		external
			"built_in"
		end

	frozen character_size: INTEGER_32
			-- Number of bytes occupied by a TCHAR.
		external
			"built_in"
		end

	frozen cwin_local_free (a_ptr: POINTER)
			-- Free `a_ptr' using LocalFree.
		external
			"built_in"
		end

feature {NONE} -- Accesss

	error_message (a_code: like hresult_code): STRING_32
		require
			a_code_non_negative: a_code >= 0
		local
			l_ptr, l_null: POINTER
			l_mptr: MANAGED_POINTER
			i, n: INTEGER
		do
			l_ptr := cwin_error_text (a_code)
			if l_ptr /= l_null then
				from
					i := 0
					n := c_strlen (l_ptr)
					create l_mptr.make_from_pointer (l_ptr, n * character_size)
					create Result.make (n)
				until
					i = n
				loop
					Result.append_code (l_mptr.read_natural_16 (i * character_size))
					i := i + 1
				end
				cwin_local_free (l_ptr)
			else
				Result := ""
			end
		ensure
			error_message_not_void: Result /= Void
		end

	frozen internal_meaning: STRING is "COM error."

end
