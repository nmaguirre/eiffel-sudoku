note
	description: "Test for class TOP_FIVE {TOP_FIVE_TEST}."
	author: "Justine Compagnon"
	date: "22/09/2013"
	revision: "NONE"

class
	TOP_FIVE_TEST

inherit
	EQA_TEST_SET

feature -- Test routines
	test_add_player_to_top_five_1
		-- Simpy test if we can add two players to top_five
	local
		player_name:STRING
		score: INTEGER
		top_five: TOP_FIVE
	do
		create top_five.init
		player_name := "toto"
		score:= 300
		top_five.add_player_to_top_five (player_name,score)
		print("player_5 : ")
		print(top_five.at (5).name)
		print("%N")
		print("player_5 : ")
		print(top_five.at (5).score)
		print("%N")
		assert ("add_player_to_top_five ok",top_five.at (1).score = 300 )
	end

	test_add_player_to_top_five_2
		-- Test if a player that should not be added to top five
		-- can be added or not
	local
		player_name:STRING
		top_five: TOP_FIVE
		worked_well : BOOLEAN
		i : INTEGER
	do
		create top_five.init
		top_five.add_player_to_top_five ("Player_One", 300)
		top_five.add_player_to_top_five ("Player_Two", 200)
		top_five.add_player_to_top_five ("Player_Three", 200)
		top_five.add_player_to_top_five ("Player_Four", 400)
		top_five.add_player_to_top_five ("Player_Five", 100)

		top_five.add_player_to_top_five ("Looser", 4000)
		--We assume it worked fine
		worked_well := True
		from
			i := 1
		until
			i > 5
		loop
			if top_five.at (i).name.is_equal ("Looser") then
				worked_well := False
			end
			i := i + 1
		end

		assert ("add_player_to_top_five player should not be added ok",worked_well)
	end

	test_sort_by_score_1
		-- Test if after adding five players to TOP_FIVE the array is sorted
	local
		top_five: TOP_FIVE
		worked_well : BOOLEAN
	do
		create top_five.init
		top_five.add_player_to_top_five ("Player_One", 300)
		top_five.add_player_to_top_five ("Player_Two", 200)
		top_five.add_player_to_top_five ("Player_Three", 200)
		top_five.add_player_to_top_five ("Player_Four", 400)
		top_five.add_player_to_top_five ("Player_Five", 100)
		worked_well := top_five.at (1).score = 100
		worked_well := worked_well and top_five.at (2).score = 200
		worked_well := worked_well and top_five.at (3).score = 200
		worked_well := worked_well and top_five.at (4).score = 300
		worked_well := worked_well and top_five.at (5).score = 400
		assert("sort_by_score TOP_FIVE sorted after five insertion ok",worked_well)
	end

feature --test routines for storing top_five and getting it from a file

	test_save_1
		-- Test if saving the top_five in a file worked
	local
		top_five: TOP_FIVE
		worked_well : BOOLEAN
		rescued : BOOLEAN
	do
		if not rescued then
			create top_five.init

			top_five.add_player_to_top_five ("Player_One", 300)
			top_five.add_player_to_top_five ("Player_Two", 200)
			top_five.add_player_to_top_five ("Player_Three", 200)
			top_five.add_player_to_top_five ("Player_Four", 400)
			top_five.add_player_to_top_five ("Player_Five", 100)

			top_five.save("dificil")
			worked_well := true
		else
			worked_well := false
		end
		assert("save ok",worked_well)
	rescue
		rescued := true
	end

end
