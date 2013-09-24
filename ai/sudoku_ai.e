note
	description	: ""
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
			unsol_board := sol_board.get_board   	--devuelve la solucion
			delete_cells(level) --level 37, 32 30 	--le elimina un par de celdas
			print ("%N Unsolved sudoku: %N")
			unsol_board.print_sudoku     			 --muestra el tablero en pantalla con unica solucion
		end

	delete_cells(level: INTEGER)				--elimina celdas en el tablero segun el nivel que se alla elegido
		local
			i,j:INTEGER
			n_borrados:INTEGER
			random_sequence:RANDOM
			random1, random2:INTEGER
			l_time: TIME
      		l_seed: INTEGER
      		loop_internal: BOOLEAN  -- Variable tilizada para almacenar si el tablero tiene unica solucion
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
							unsol_board.unset_cell (random1,random2)    -- borra la celda en esa cordenada
							loop_internal := False
						else
							loop_internal := True
						end -- end if
			   	    end -- end if
				end -- end loop
			n_borrados := n_borrados - 1
			end
		end

feature --is_unicity

	is_unicity (random1: INTEGER; random2:INTEGER ): BOOLEAN
		local
			i,cont: INTEGER
		do
           	cont:= 0    --Contador de validos
			from        -- Pruebo para todos los valores , cuantos pueden ir
				i := 1
			until
				i = 9
			loop
--				si el tablero es valido incremento un contador de validos
--				si el contdor de validos es mayor a dos entonces el tablero tiene mas de una slucion por lo tanto false me devuelve
--              va comensar probando con 1 despues con 2 y asi secesivamente, del 1 al 9

				if unsol_board.set_cell (random1, random2, i)    -- cuando esto es true incrementa el contador
				then
				    unsol_board.unset_cell (random1,random2)     -- Vuelvo la celda a void para probar con otro valor
					cont := cont + 1      -- Incremento el contador
				else
					cont := cont + 0  -- Si no, no le hago ningun cambio a cantador
				end
				i := i + 1 --Paso a probar el siguiente numero
			end
			if 	cont >= 2 -- Osea que pueden ir mas de un valor en la misma celda.
			then
				Result := False 	-- No es el unico valor que puedo poner, No es unica la solucion
			else
				Result := True		-- Si, es el unico valor que puedo poner, Si es unica la solucion
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
