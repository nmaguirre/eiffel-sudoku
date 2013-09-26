note
	description	: "creates a sudoku board with solution"
	author		: "Pablo Marconi, Farias Pablo, Dario Astorga, Matias Alvarez"
	date		: "22/09/2013"
	revision	: "v0.1"

class
	SUDOKU_AI

create
	make_with_level

feature {NONE} -- Initialization

	sol_board: AI_SOLUTION
	unsol_board: SUDOKU_BOARD
	hint_counter: INTEGER

	make_with_level(level:INTEGER)
			-- Initialization for `Current'.
		do
			create sol_board.make
			create unsol_board.make --unsolved board
			unsol_board := sol_board.get_board
			delete_cells(level) --level 37, 32 30 	
			print ("%N Unsolved sudoku: %N")
			unsol_board.print_sudoku

		end

	delete_cells(level: INTEGER)
		require
			correct_level: level=37 or level=32 or level=30
			unsol_board/=Void
		local
			n_borrados:INTEGER
			random_sequence:RANDOM
			random1, random2:INTEGER
			l_time: TIME
      		l_seed: INTEGER
      		loop_internal: BOOLEAN
		do
			from
				if level = 37 then
					n_borrados := 1 --Numbers of delete cells in easy level
				else if level = 32 then
					n_borrados := 2 --Numbers of delete cells in medium level
					else if level = 30 then
						n_borrados := 3 --Numbers of deletes cells in hard level
					end
				end
				end
			until
				n_borrados < 1
			loop

			  	from
			     	loop_internal := True
			 	until
			     	loop_internal = False
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
						if is_unicity(random1,random2) = true
						then
							unsol_board.unset_cell (random1,random2)
							loop_internal := False
						else
							loop_internal := True
						end -- end if
			   	    end -- end if
				end -- end loop
			n_borrados := n_borrados - 1
			end

		ensure
			valid_board: unsol_board.is_valid
		end

feature -- is_unicity

	is_unicity (random1: INTEGER; random2:INTEGER ): BOOLEAN
		require
			(random1 > 0 and random1 < 10) and (random2 > 0 and random2 < 10)
		local
			i,cont: INTEGER
		do
           	cont:= 0
			from
				i := 1
			until
				i = 9
			loop

				if unsol_board.set_cell (random1, random2, i)
				then
				    unsol_board.unset_cell (random1,random2)
					cont := cont + 1
				else
					cont := cont + 0
				end
				i := i + 1
			end
			if 	cont >= 2
			then
				Result := False
			else
				Result := True  -- Yes, it is the only value that I can bring.
			end
		end

feature -- Access

	get_unsolved_board:SUDOKU_BOARD    --Devuelve un tablero resuelto
		do
			Result := unsol_board
		end

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
