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

	set_multiplayer_window(v: MULTIPLAYER_WINDOW)
	do
		view := v
	end

	paint_cell(x, y : INTEGER)
	do
		view.paint_cell(x,y)
	end

	unpaint_cell(x, y : INTEGER)
	do
		view.unpaint_cell(x,y)
	end
end
