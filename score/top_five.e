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

feature {ANY}
	add_player_to_top_five (player_name: STRING; player_score: INTEGER)
	require
		score_is_valid : player_score > 0
	local
		new_player_top_five:PLAYER_TOP_FIVE
		score_fift_player: integer
	do
		score_fift_player:= current.at (5).score
		print("score_fift_player is : ")
		print(score_fift_player)
		print("%N")
		print("score_player is : ")
		print(player_score)
		print("%N")
		-- if the score of the new player is higher than the score of the last player of the list
		-- we replace the last player by him
		if  score_fift_player > player_score then
			-- we create the new player
			create  new_player_top_five.make_with_param (player_name, player_score)
			-- we give the last spot to our new player
			put (new_player_top_five, 5);
			-- and now we sort the array
			sort_by_score()
		end
	end






feature {NONE} --Sorting array

	sort_by_score()
		-- Call this function after each insertion to make sure TOP_FIVE stays sorted.
	do
		bubble_sort_by_score(Current);
	end

	bubble_sort_by_score(array_to_sort : ARRAY[PLAYER_TOP_FIVE])
		-- Algorithm based on BubbleSort used by sort_by_score to sort an array of PLAYER_TOP_FIVE
		-- thanks to their score.
	local
		i : INTEGER
		index_new_player : INTEGER
		placed : BOOLEAN
	do
		--as we assume array is already sorted but not the last one.
		--we just have to bubble up the last one
		from
			i := 4
			index_new_player := 5
		until
			i < 1 or placed
		loop
			if array_to_sort.at (i).score > array_to_sort.at (index_new_player).score then
				permute(array_to_sort,i,index_new_player)
				index_new_player := i
			else
				placed := true
			end

			i := i - 1
		end
	end

	permute(array : ARRAY[PLAYER_TOP_FIVE]; i,j : INTEGER)
	require
		i_inside_array : array.lower <= i AND i <= array.upper
		j_inside_array : array.lower <= j AND j <= array.upper
		i_j_different : i /= j
	local
		player_copie : PLAYER_TOP_FIVE
	do
		player_copie := array.at (i)
		array.put (array.at (j), i)
		array.put (player_copie, j)
	end

feature {ANY} --storing and getting from file

	save (level : STRING)
		--save the top_five in a file.
		--there is a file by level
	do
		-- print("Saving top_five as :" + "./score/store_top_five/" + level + "_top_five" + "%N")
		store_by_name ("./score/store_top_five/" + level + "_top_five")
	end


end


