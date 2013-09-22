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
		create default_player.make
		make_filled (default_player,1,5)
	end










feature {NONE} --Sorting array

	sort_by_score()
	do
		bubble_sort_by_score(Current);
	end

	bubble_sort_by_score(array_to_sort : ARRAY[PLAYER_TOP_FIVE])
	-- Call this function after each insertion to make sure TOP_FIVE stays sorted.
	-- Algorithm based on BubbleSort
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

end
