note
	description	: "{SUDOKU_CELL} represents cells of a SUDOKU board. A cell can be empty, or contain a value between 1 and 9."
	author		: "N. Aguirre, R. Degiovanni, N. Ricci"
	date		: "04/09/2013"
	revision	: "0.1"

class
	SUDOKU_CELL

create
	make, make_with_value

feature -- Initialization
	make
		-- Default constructor of class.
		-- Makes the cell "empty", i.e., unset.
	do
		value:= 0
		settable:=true --celd settable default
	ensure
		-- is_set value is false and value is initially 0
		is_set = false and value = 0
	end

		make_with_value (new_value: INTEGER)
			-- Constructor of the class
			-- Initializes the cell set with new_value
		require
			new_value > 0
			new_value < 10
		do
			value := new_value
		ensure
			value = new_value
			is_set = True
		end

feature -- Access

	value: INTEGER assign set_value
		-- Value of the cell. When set, contains a valid value between 1 and 9
	settable: BOOLEAN
		-- field that indicates if cell is settable. You can't change cell that has been initialized at beginning


feature -- Status report

	is_set: BOOLEAN
		-- Indicates if this cell is set.
		do
			Result := value /= 0
		end

feature -- Status setting

	get_value: INTEGER
		-- get value
		do
			Result := value
		end

	set_value (new_value: INTEGER)
		-- Sets the cell with new_value
		require
			new_value >= 0 and new_value < 10
		do
			value := new_value
		ensure
			value = new_value -- and is_set = true set_value is used for set with 0 too!!!
		end

feature{ANY}
	is_settable(val:BOOLEAN)
	do
		settable:=val
	end

invariant

	cell_value: value >= 0 and value <= 9 -- The value of the cell is always between 0 and 9 (0 when created and 1-9 when seted)

end
