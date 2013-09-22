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
	

end
