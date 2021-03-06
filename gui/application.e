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

	sudokuai:SUDOKU_AI

	make_and_launch
			-- Initialize and launch application
		do
			 --test_solver;
			 default_create
			 prepare
			 launch
		end

	prepare
	local
		creator: WINDOW_FACTORY
			-- Prepare the first window to be displayed.
			-- Perform one call to first window in order to
			-- avoid to violate the invariant of class EV_APPLICATION.
		do
				-- create and initialize the first window.
			create creator.default_create
			first_window:= creator.factory_method (1)

				-- Show the first window.
				--| TODO: Remove this line if you don't want the first
				--|       window to be shown at the start of the program.
			first_window.show

			-- Connect controller with gui
			create controller.make -- controller create
			first_window.set_controller(controller) -- set a controller in main windows
			controller.set_main_window(first_window) --set a gui in controller
		end

feature {NONE} -- tests for sudoku_solver

	test_solver
	local
		solver : SUDOKU_SOLVER
		board : SUDOKU_BOARD
	do
		print("###############%N")
		print("## TEST_INIT ##%N")
		print("###############%N")
		create board.make
		create solver.init_with_board (board)
		if solver.is_initialized then
			print("Solver initialized ---> OK %N")
		else
			print("Solver not initialized ---> FAIL %N")
		end
		if solver.has_board_to_solve then
			print("Solver has a board to solve ---> OK %N")
		else
			print("Solver does not have a board to solve ---> FAIL  %N")
		end
		print("###################%N")
		print("## TEST_GENERATE ##%N")
		print("###################%N")
		board := solver.generate_model
		solver.set_model(board)
		print("################%N")
		print("## TEST_SOLVE ##%N")
		print("################%N")
		print("---> Postits before solve : %N")
		solver.print_postits
		print("---> Currently solving sudoku... %N")
		solver.solve_board
		print("---> Postits after solve : %N")
		solver.print_postits
		print("---> Result :%N")
		solver.get_model.print_sudoku
	end

feature {NONE} -- Implementation

	first_window: ABSTRACT_MAIN_WINDOW
			-- Main window.

	controller: SUDOKU_CONTROLLER

end -- class APPLICATION
