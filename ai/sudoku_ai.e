note
	description	: "Summary description for {AI}."
	author		: ""
	date		: "$Date$"
	revision	: "$Revision$"

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
			create unsol_board.make --vacio
			-- pongo el board solucionado al unsol para despues borrarle celdas al unsol
			unsol_board := sol_board.get_board
			delete_cells(10) --llevaria como parametro el nivel
			print ("%N")
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
			--if de niveles
			--n_borrados := level -- a cambiar despues
			--ciclo
			from
				n_borrados := level
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
				-- compruebo que la celda a borrar ya esta seteada
				if unsol_board.cell_set (random1,random2) then --?
					-- Si el valor esta seteado
					unsol_board.unset_cell (random1,random2)
					n_borrados := n_borrados - 1
					--si el valor no esta seteado no deberia restar n_borrado
					--comprobar unicidadddddddddddd					
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
