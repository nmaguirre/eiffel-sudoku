note
	description	: ""
	author		: "Pablo Marconi, Farias Pablo, Dario Astorga, Matias Alvarez, Diego Gastaldi"
	date		: "26/09/2013"
	revision	: "v0.1"

class
	SUDOKU_AI

create
	make_with_level

feature {NONE} -- Initialization

	sol_board: SUDOKU_BOARD
	unsol_board: SUDOKU_BOARD
	hint_counter: INTEGER
	hint: SUDOKU_HINT

	make_with_level(level:INTEGER)
		do
			create sol_board.make --solution board
			generate_solution
			create unsol_board.make --unsolved board
			sol_board.print_sudoku
			unsol_board.deep_copy(sol_board)
			delete_cells(level) --level 37, 32 30
			print ("%N Sudoku solution: %N")
			sol_board.print_sudoku
			print ("%N valid? " + sol_board.is_solved.out + "%N")
			print ("%N Unsolved sudoku: %N")
			unsol_board.print_sudoku

		end

	generate_solution
		local
			i,j,n: INTEGER_32
			l: ARRAY2[INTEGER]
			random_number:RANDOM_NUMBER
			random1, random2:INTEGER
		do
			create l.make_filled (0,9,9)
			n := 1
			from
				i := 1
			until
				i > 9
			loop
				from
					j := 1
				until
					j > 9
				loop
					if i = 2 and j = 1 then
						n := 4
					else if i = 3 and j = 1  then
						n := 7
					else if i = 4 and j = 1  then
						n := 2
					else if i = 5 and j = 1  then
						n := 5
					else if i = 6 and j = 1  then
						n := 8
					else if i = 7 and j = 1  then
						n := 3
					else if i = 8 and j = 1  then
						n := 6
					else if i = 9 and j = 1  then
						n := 9
					end
					end
					end
					end
					end
					end
					end
					end
					if not sol_board.set_cell (i,j,n)  then
						print ("%N error set_cell %N")
					end
					j := j + 1
					n :=  ((n+1) \\ 10)
					if n = 0 then
						n:= 1
					end
				end
				i := i + 1
			end

			from
				n := 1
			until
				n > 100 -- numbers of swaps
			loop
				create random_number.make
				random1 := random_number.random_integer
				random2 := random_number.random_integer
				swap(random1,random2)
				n := n + 1
			end
		ensure
			sol_board.is_solved
		end

	swap(n,m:INTEGER)
		--Swap values 'n' and 'm'
		local
			i,j:INTEGER
		do
			from
				i := 1
			until
				i > 9
			loop
				from
					j := 1
				until
					j > 9
				loop
					if sol_board.cell_value (i,j) = n then
						if sol_board.set_cell (i,j,m) then
							--print ("swaping...")
						end
					else if sol_board.cell_value (i,j) = m then
						if sol_board.set_cell (i,j,n) then
							--print ("swaping...")
						end
					end
					end
					j := j + 1
				end
				i := i + 1
			end
		end

	delete_cells(level: INTEGER)
		local
			n_borrados:INTEGER
			random: RANDOM_NUMBER
			random1, random2:INTEGER
		do
			from
				if level = 37 then
					n_borrados := 1 --Numbers of delete cells in easy level
				else if level = 32 then
					n_borrados := 2 --Numbers of delete cells in medium level
				else if level = 30 then
					n_borrados := 3 --Numbers of deletes cells in hard level
				else
					n_borrados := 4
				end
				end
				end
			until
				n_borrados < 1
			loop
			  	create random.make
				random1:= random.random_integer
				random2:= random.random_integer
				if unsol_board.cell_set (random1,random2) then
					unsol_board.unset_cell (random1,random2)
					n_borrados := n_borrados - 1
			   	end
			end
	 end

feature -- hint

feature -- Access

	get_unsolved_board:SUDOKU_BOARD    --Devuelve un tablero resuelto
		do
			Result := unsol_board
		end

	get_sol_board:SUDOKU_BOARD   --Devuelve un tablero resuelto
		do
			Result := sol_board
		end

	get_solution(x,y:INTEGER):INTEGER
		do
			Result := sol_board.cell_value (x,y)
		end


feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
