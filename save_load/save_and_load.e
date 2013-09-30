note
	description: " Class to save (or load) a game {SAVE_AND_LOAD}."
	author: "Matias Donatti"
	date: "24/09/13"
	revision: "0.2"

class
	SAVE_AND_LOAD

inherit
	STORABLE

create
	init

feature {ANY} --Initialize
	init(single_player:SINGLE_PLAYER_STATE)
	once
		the_instance:=current
		game := single_player
		name_game := ""
	end

feature {ANY} -- save on file
	save(new_name_game:String)
		--Save game with name new_name_game
	require
		new_name_game.count>0
	do
		store_by_name ("./save_load/games/"+new_name_game)
		name_game := new_name_game
	end

feature {ANY} -- open from file
	load(new_name_game:STRING)
		--Open game with name new_name_game
	require
		new_name_game.count>0
	local
		obj_retrieved : ANY
	do
		obj_retrieved := retrieve_by_name ("./save_load/games/"+new_name_game)
		if attached {SAVE_AND_LOAD} obj_retrieved as file then
			set_single_player_state(file.get_single_player_state)
			name_game := new_name_game
		end
	end

feature {ANY} -- Access

	get_single_player_state:SINGLE_PLAYER_STATE
		-- Obtain the SINGLE PLAYER STATE
	do
		result:= game
	end

	set_single_player_state(single_player:SINGLE_PLAYER_STATE)
		-- Changed the SINGLE PLAYER STATE
	do
		game:= single_player
	end

	already_saved:BOOLEAN
		-- Verify if the game already saved
	do
		result := not name_game.is_equal ("")
	end

feature {NONE}
	the_instance: SAVE_AND_LOAD
	game:SINGLE_PLAYER_STATE
	name_game:STRING
		--Name of game current
end
