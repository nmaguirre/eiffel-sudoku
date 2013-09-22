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
	test_add_player_to_top_five
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
		assert ("add_player_to_top_five ok",top_five.at (5).score = 300 )
	end

end
