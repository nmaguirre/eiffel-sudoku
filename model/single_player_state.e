note
	description: "Summary description for {SINGLE_PLAYER_STATE}."
	author: "E. Marchisio"
	date: "10/01/2013"
	revision: "$Revision$"

class
	SINGLE_PLAYER_STATE

inherit
	STORABLE

create
	make, make_level

feature {ANY}

	make(ai_new: SUDOKU_AI)
	do
		if ai_new=Void then
			create ai.make
		else
			ai:= ai_new
		end
	end

	make_level(level:INTEGER)
	do
		create ai.make_with_level(level)
	end

	-- creates the timer
	make_timer
	do
		create timer.make
	end

	timer:CLOCK -- the clock

	-- Returns a hint for the respective board
	get_hint:SUDOKU_HINT
	do
		Result:= ai.get_hint(board)
	end

	-- Returns the current board
	board:SUDOKU_BOARD
	do
		Result:= ai.get_unsolved_board
	end

	get_hint_number:INTEGER
	do
		Result:= ai.get_hint_counter
	end

feature {SINGLE_PLAYER_STATE}

	ai:SUDOKU_AI -- AI that will contains the unsolved board and the solved board

feature {ANY}

	hint_not_settable(row,col: INTEGER)
	do
		ai.one_cell_not_settable(row,col)
	end

feature {ANY}
  sps_equals(otherstate : SINGLE_PLAYER_STATE) : BOOLEAN
  local
    i,j : INTEGER
    equals : BOOLEAN
  do
    if (current = Void or otherstate = Void) then
      if (current = Void) then
        print("In sps_equals : the current state is empty")
      end
      if (otherstate = Void) then
        print("In sps_equals : otherstate is empty")
      end
    else
      -- Let's say they are equals and we verify everything until we are not sure they are 100% equals
      equals := True
    end


      --first check time :
      print("In sps_equals : First check time")
      if (current.timer = void or otherstate.timer = void) then
        if not(current.timer = void and otherstate.timer = void) then
          equals := False
        end
      else
        if (not current.timer.is_equal (otherstate.timer)) then
          print("Timers are differents")
          equals := False
        end
      end

      if not( current.ai.get_sol_board.boards_equal(otherstate.ai.get_sol_board) ) then
      	equals:= False
      	end

      if not( current.ai.get_unsolved_board.boards_equal(otherstate.ai.get_unsolved_board) ) then
      	equals:= False
      	end

      Result:= equals
  end

end
