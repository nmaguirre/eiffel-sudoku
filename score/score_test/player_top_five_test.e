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


feature {ANY} -- Test routing setter

test_set_name_and_score_1
	local
		player: PLAYER_TOP_FIVE
		worked_well: BOOLEAN
	do
		-- we suppose that the test work
		worked_well:= true;
		create player.make
		player.set_name ("François")
		player.set_score (800)
		if (not player.name.is_equal ("François")) or (player.score /= 800) then
			worked_well:= false;
		end
		assert ("set_name_and_score_player_top_five ok", worked_well )
	end

-- check if require score > is working
test_set_name_and_score_2
	local
		player: PLAYER_TOP_FIVE
		worked_well: BOOLEAN
	do
		-- we suppose that the test work
		worked_well:= true;
		create player.make
		player.set_name ("François")
		player.set_score (-5)
		print(player.out)
		if (not player.name.is_equal ("François")) or (player.score /= -5) then
			worked_well:= false;
		end
		assert ("set_name_and_score_player_top_five ok", worked_well )
	end



feature -- test out

test_out
	local
		player: PLAYER_TOP_FIVE
		worked_well: BOOLEAN
	do
		create player.make
		player.set_name ("François")
		player.set_score (800)
		print(player.out)
		assert ("out_player_top_five ok", player.out.is_equal ("François : 800") )
	end


feature -- test score

test_score
	local
		player: PLAYER_TOP_FIVE
		worked_well: BOOLEAN
		time: TIME_DURATION
	do
		create time.make_by_seconds (800)
		create player.make
		assert ("calculate_score_player_top_five ok", player.calculate_score (time) = 800)
	end


end
