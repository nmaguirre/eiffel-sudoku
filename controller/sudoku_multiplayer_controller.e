note
	description: "Summary description for {SUDOKU_MULTIPLAYER_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SUDOKU_MULTIPLAYER_CONTROLLER

feature{ANY}

    view: ABSTRACT_MAIN_WINDOW

	multiplayer: MULTIPLAYER_STATE

	set_multiplayer_window(v: ABSTRACT_MAIN_WINDOW)
	do
		view:= v
	end

	paint_cell
	do

	end

	unpaint_cell
	do

	end
end
