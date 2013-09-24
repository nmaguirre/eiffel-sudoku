note
	description: "{PLAYER_TOP_FIVE} : Object that will be present in the array of top_five players. A player present in TOP_FIVE as a name and a score"
	author: "Gabriel Mabille"
	date: "22/09/13"
	revision: "NONE"

class
	PLAYER_TOP_FIVE

inherit
	STORABLE
	undefine
		out
	end

create
	make,
	make_with_param

feature -- Initialize

	make
	    -- Makes a player with name = “Unknown” and score = “-1”
	do
		name := "Unknown"
		score := -1
	end

	make_with_param(player_name : STRING; player_score : INTEGER)
		-- Makes a player with name = player_name and score = player_score
	require
		positive_score : player_score > 0
	do
		name := player_name
		score := player_score
	end

feature -- Set

	set_name(new_name : STRING)
		-- Sets the player name to new_name
	do
		name := new_name
	end

	set_score(new_score : INTEGER)
		-- Sets the player score to new_score
	require
		positive_score : new_score > 0
	do
		score := new_score
	end

feature -- Intern variables

	name : STRING
		-- Returns the player name

	score : INTEGER
		-- Returns the player score

feature -- out

	out : STRING
		-- Returns a string representing the current object
	do
		result := name + " : " + score.out
	end
end
