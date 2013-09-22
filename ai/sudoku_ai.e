note
	description	: ""
	author		: "Marconi-Alvarez-Farias-Astorga"
	date		: "22/09/2013"
	revision	: "v0.1"

class
	SUDOKU_AI

create
	make

feature {NONE} -- Initialization

	sol_board: AI_SOLUTION
	unsol_board: SUDOKU_BOARD
	hint_counter: INTEGER

	make
			-- Initialization for `Current'.
		do
			create sol_board.make
			create unsol_board.make --unsolved board
			unsol_board := sol_board.get_board
			delete_cells(3) --level 1, 2 or 3
			print ("%N Unsolved sudoku: %N")
			unsol_board.print_sudoku
		end

	delete_cells(level: INTEGER)
		local
			i,j:INTEGER
			n_borrados:INTEGER
			random_sequence:RANDOM
			random1, random2:INTEGER
			l_time: TIME
      		l_seed: INTEGER
		do
			from
				if level = 1 then
					n_borrados := 1
				else if level = 2 then
					n_borrados := 2
				else if level = 3 then
					n_borrados := 3
				end
				end
				end
			until
				n_borrados < 1
			loop
				create l_time.make_now
   				l_seed := l_time.hour
   				l_seed := l_seed * 60 + l_time.minute
   				l_seed := l_seed * 60 + l_time.second
   				l_seed := l_seed * 1000 + l_time.milli_second
   				create random_sequence.set_seed (l_seed)
   				create l_time.make_now
   				l_seed := l_time.hour
   				l_seed := l_seed * 60 + l_time.minute
   				l_seed := l_seed * 60 + l_time.second
   				l_seed := l_seed * 1000 + l_time.milli_second
   				create random_sequence.set_seed (l_seed)
   				random_sequence.forth
				random1 := random_sequence.item \\ 9 + 1
				random_sequence.forth
				random2 := random_sequence.item \\ 9 + 1
				--print( random1.out +" "+ random2.out )
				if unsol_board.cell_set (random1,random2) then
					unsol_board.unset_cell (random1,random2)
					n_borrados := n_borrados - 1
					--check unicity
				end
			end
		end

feature -- Access

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
