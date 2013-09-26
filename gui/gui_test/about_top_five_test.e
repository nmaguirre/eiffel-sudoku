note
	description: "{ABOUT_TOP_FIVE_TEST} is used to test class {ABOUT_TOP_FIVE}."
	author: "Gabriel Mabille"
	date: "25/09/2013"
	revision: "NONE"

class
	ABOUT_TOP_FIVE_TEST

inherit
	EQA_TEST_SET

feature {ANY} -- test initialize

	test_initialize
		-- Test if window about_top_five can be shown
	local
		window : ABOUT_TOP_FIVE
	do
		create window
		window.show
		assert("about top five is displayed", window.is_displayed)
	end


	test_initialize_1
		-- Test if window about_top_five has the size we wanted
	local
		window : ABOUT_TOP_FIVE
		size_ok : BOOLEAN
	do
		create window
		size_ok := window.width = 370
		size_ok := size_ok and window.height = 380
		assert("about top five window has good size", size_ok)
	end
end
