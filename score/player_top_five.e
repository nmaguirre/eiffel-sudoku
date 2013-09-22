note
	description: "Object that will be present in the array of top_five players"
	author: "Gabriel Mabille"
	date: "22/09/13"
	revision: "NONE"

class
	PLAYER_TOP_FIVE

inherit
	STORABLE

create
	make,
	make_with_param

feature -- Initialize

	make
	do
		name := "Unknown"
		score := 0
	end

	make_with_param(player_name : STRING; player_score : INTEGER)
	do
		name := player_name
		score := player_score
	end

feature -- Set

	set_name(new_name : STRING)
	do
		name := new_name
	end

	set_score(new_score : INTEGER)
	do
		score := new_score
	end

feature -- Intern variables

	name : STRING
	score : INTEGER

end
