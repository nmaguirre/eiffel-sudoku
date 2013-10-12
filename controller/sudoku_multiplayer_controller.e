note
	description: "Summary description for {SUDOKU_MULTIPLAYER_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SUDOKU_MULTIPLAYER_CONTROLLER
create
	make

feature{ANY}

    view: MULTIPLAYER_WINDOW

	make
	do
	end

    -- Take a board and displays it into the MULTIPLAYER_WINDOW
    load_board(new_board: SUDOKU_BOARD)
	require
		valid_board: new_board /= Void
    local
		i: INTEGER
		j: INTEGER
	do
		from
			i:=1
		until
			i>9
		loop
			from
				j:=1
			until
				j>9
			loop
				if(new_board.cell_set(i,j)) then
					view.paint_cell(i,j)
				else
					view.unpaint_cell(i,j)
				end
				j:=j+1
			end
			i:=i+1
		end
    end

	-- Sets the view of this controller
    set_multiplayer_window(v: MULTIPLAYER_WINDOW)
	require
		valid_view: v /= Void
	do
		view := v
	end

	-- Paints a cell in the view
	paint_cell(x, y : INTEGER)
	require
        valid_cell_row: x>=0 and x<=9
        valid_cell_col: y>=0 and y<=9
	do
		view.paint_cell(x,y)
	end

	-- Unpaint a cell in the view
	unpaint_cell(x, y : INTEGER)
	require
        valid_cell_row: x>=0 and x<=9
        valid_cell_col: y>=0 and y<=9
	do
		view.unpaint_cell(x,y)
	end
end
