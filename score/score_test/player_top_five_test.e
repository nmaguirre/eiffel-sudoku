note
	description: "Test {PLAYER_TOP_FIVE_TEST}."
	author: "Justine Compagnon"
	date: "26/09/2013"
	revision: "NONE"

class
	PLAYER_TOP_FIVE_TEST
inherit
	EQA_TEST_SET

feature {ANY} -- Test routing make

test_make
	local
		player: PLAYER_TOP_FIVE
		worked_well: BOOLEAN
	do
		-- we suppose that the test work
		worked_well:= true;
		create player.make
		if (not player.name.is_equal ("Unknown")) or (player.score /= -1) then
			worked_well:= false;
		end
		assert ("make_player_top_five ok", worked_well )
	end


test_make_default
	local
		player: PLAYER_TOP_FIVE
		worked_well: BOOLEAN
	do
		-- we suppose that the test work
		worked_well:= true;
		create player.make_with_param ("Simpson", 500)
		if (not player.name.is_equal ("Simpson")) or (player.score /= 500) then
			worked_well:= false;
		end

		assert ("make_default_player_top_five ok", worked_well )
	end


end
