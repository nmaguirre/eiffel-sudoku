note
	description	: "Eiffel tests that can be executed by testing tool."
	author		: "EiffelStudio test wizard"
	date		: "Date"
	revision	: "Revision"
	testing		: "type/manual"

class
	SUDOKU_CELL_TEST_SET

inherit
	EQA_TEST_SET

feature -- Test routines

	test_make_0
			-- Cell is unset after default creation
		note
			testing:  "covers/{SUDOKU_CELL}.make"
		local
			cell: SUDOKU_CELL
		do
			create cell.make
			assert ("cell not set", not cell.is_set)
		end

	test_make_1
			-- Cell is unset after default creation
		note
			testing:  "covers/{SUDOKU_CELL}.make"
		local
			cell: SUDOKU_CELL
		do
			create cell.make
			assert ("cell has value 0", cell.value = 0)
		end

	test_make_with_value_0
			-- Cell is set with provided value
		note
			testing:  "covers/{SUDOKU_CELL}.make"
		local
			cell: SUDOKU_CELL
		do
			create cell.make_with_value (5)
			assert ("cell is set", cell.is_set)
		end

	test_make_with_value_1
			-- Cell is set with provided value
		note
			testing:  "covers/{SUDOKU_CELL}.make"
		local
			cell: SUDOKU_CELL
		do
			create cell.make_with_value (5)
			assert ("cell is set", cell.value = 5)
		end

	test_make_with_value_2
			-- Cell breaks when set with an invalid value
		note
			testing:  "covers/{SUDOKU_CELL}.make"
		local
			cell: SUDOKU_CELL
			passed: BOOLEAN
			rescued: BOOLEAN
		do
			if (not rescued) then
				create cell.make_with_value (10)
				passed := True
			end
			assert ("make_with_value broke", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end

    test_set_value_with_value_5
        -- Verify that the cell is seted with the value 1.
		note
			testing:  "covers/{SUDOKU_CELL}.set_value"
		local
			cell: SUDOKU_CELL
            aux: INTEGER
		do
			create cell.make
            aux:= 5
            cell.set_value(aux)
            assert ("cell not set", cell.value=aux and cell.is_set)
		end

	test_set_value_with_value_0
			-- Cell breaks when set with an invalid value
		note
			testing:  "covers/{SUDOKU_CELL}.set_value"
		local
			cell: SUDOKU_CELL
			passed: BOOLEAN
			rescued: BOOLEAN
		do
			if (not rescued) then
				create cell.make
                cell.set_value(0)
				passed := True
			end
			assert ("set_with_value_0 broke", passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end

	test_set_value_with_value_10
			-- Cell breaks when set with an invalid value
		note
			testing:  "covers/{SUDOKU_CELL}.set_value"
		local
			cell: SUDOKU_CELL
			passed: BOOLEAN
			rescued: BOOLEAN
		do
			if (not rescued) then
				create cell.make
                cell.set_value(10)
				passed := True
			end
			assert ("set_with_value_10 broke", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end

end


