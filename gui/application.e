note
	description	: "Root class for this application."
	author		: "Generated by the New Vision2 Application Wizard."
	date		: "2013/8/16 9:20:39"
	revision	: "1.0.0"

class
	APPLICATION

inherit
	EV_APPLICATION

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch
			-- Initialize and launch application
		do
			default_create
			prepare
			launch
		end

	prepare
			-- Prepare the first window to be displayed.
			-- Perform one call to first window in order to
			-- avoid to violate the invariant of class EV_APPLICATION.
		do
				-- create and initialize the first window.
			create first_window

				-- Show the first window.
				--| TODO: Remove this line if you don't want the first
				--|       window to be shown at the start of the program.
			first_window.show

			-- Connect controller with gui
			create controller.make -- controller create
			first_window.set_controller(controller) -- set a controller in main windows
			controller.set_main_window(first_window) --set a gui in controller
		end

feature {NONE} -- Implementation

	first_window: MAIN_WINDOW
			-- Main window.

	controller: SUDOKU_CONTROLLER

end -- class APPLICATION
