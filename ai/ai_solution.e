note
	description	: "Solution of sudoku"
	author		: "Pablo Marconi, Farias Pablo, Dario Astorga, Matias Alvarez"
	date		: "20/09/2013"
	revision	: "v0.1"

class
	AI_SOLUTION

create
	make

feature {NONE} -- Initialization

	sol_board: SUDOKU_BOARD

	make
		do
			generate_initial_solution
		end

	generate_initial_solution
		local
			i,j,n: INTEGER_32
			l: ARRAY2[INTEGER]
			random_sequence:RANDOM
			random1, random2:INTEGER
			l_time: TIME
      		l_seed: INTEGER
		do
			create sol_board.make
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
			--print ("initial sudoku: %N")
			--sol_board.print_sudoku
			--------------------------
			from
				n := 1
			until
				n > 100 -- numbers of swaps
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
				swap(random1,random2)
				n := n + 1
			end
			-- Printing sudoku solution
			print ("%N Sudoku solution: %N")
			sol_board.print_sudoku
			print ("%N valid? " + sol_board.is_solved.out)
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


feature -- Access

	get_board:SUDOKU_BOARD
		do
			Result := sol_board
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
