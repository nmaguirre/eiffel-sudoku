note
	description: "ARRAY of the five best player {TOP_FIVE}."
	author: "Justine Compagnon"
	date: "22/09/2013"
	revision: "NONE"

class
	TOP_FIVE

inherit
	STORABLE
	undefine
		out
	end

	ARRAY[PLAYER_TOP_FIVE]
	undefine
		is_equal,copy,out
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


feature {ANY} -- control

	is_player_making_top_five(score: INTEGER): BOOLEAN
		-- Tell if the player_top_five is in the top five or not
	local
		score_fift_player: INTEGER
		player_in_top_five: BOOLEAN
	do
		score_fift_player:= current.at (5).score
		-- if the score of the new player is higher than the score of the last player of the list
		-- the the new player is in the top five
		if  score_fift_player >= score then
			player_in_top_five := true
		else
			player_in_top_five := false
		end
		result := player_in_top_five
	end


feature {ANY} -- adding

	add_player_to_top_five (player_name: STRING; player_score: INTEGER)
		-- Create a new player thanks to his name and his score then add it to top five if he deserves it
	require
		score_is_valid : player_score > 0
		is_player_making_top_five(player_score)

	local
		new_player_top_five:PLAYER_TOP_FIVE
		score_fift_player: integer
	do
		score_fift_player:= current.at (5).score
		-- we create the new player
		create  new_player_top_five.make_with_param (player_name, player_score)
		-- we give the last spot to our new player
		put (new_player_top_five, 5);
		-- and now we sort the array
		sort_by_score()
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

	retrieve (level : STRING)
		--retrieve the top_five from the corresponding level file.
	local
		obj_retrieved : ANY
		i : INTEGER
	do
		obj_retrieved := retrieve_by_name ("./score/store_top_five/" + level + "_top_five")
		if attached {TOP_FIVE} obj_retrieved as existing_top_five then
			from
				i := 1
			until
				i > 5
			loop
				put(existing_top_five.at (i),i)
				i := i + 1
			end
		end
	end


	out: STRING
    	-- Returns a string representing the current object
    local
    	list: STRING
    	i: INTEGER
   	do
   		create list.make_empty
    	from
    		i:= 1
    	until
    		i = 6
    	loop
    		list.append (Current.at (i).out)
    		list.append ("%N")
    		i:= i + 1
    	end
    result := list
   	end

end


