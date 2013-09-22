note
	description: "ARRAY of the five best player {TOP_FIVE}."
	author: "Justine Compagnon"
	date: "22/09/2013"
	revision: "NONE"

class
	TOP_FIVE

inherit
	STORABLE

	ARRAY[PLAYER_TOP_FIVE]
	undefine
		is_equal,copy
	end

create
	init

feature {ANY} --Initialize
	init
	local
		default_player : PLAYER_TOP_FIVE
	do
		create default_player.make_with_param ("Unknow", 600000)
		make_filled (default_player,1,5)
	end



feature {ANY} --	
	add_player_to_top_five (player_name: STRING; player_score: INTEGER)
	local
		new_player_top_five:PLAYER_TOP_FIVE
		score_fift_player: integer
	do
		score_fift_player:= current.at (5).score
		print("score_fift_player is : ")
		print(score_fift_player)
		print("%N")
		-- if the score of the new player is higher than the score of the last player of the list
		-- we replace the last player by him
		if  score_fift_player > player_score then
			-- we create the new player
			create  new_player_top_five.make_with_param (player_name, player_score)
			-- we give the last spot to our new player
			put (new_player_top_five, 5);
			-- and now we sort the array
			-- sort_by_score()
		end
	end
end


