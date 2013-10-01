note
	description: "Summary description for {WINDOW_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WINDOW_FACTORY

create
	default_create

feature
	factory_method(w:INTEGER): ABSTRACT_MAIN_WINDOW
	local
		w1:MAIN_WINDOW
		w2:SKIN_SKY
		w3:SKIN_BLUE_GREEN
	do
		if w=1 then
			create w1.default_create
			result:=  w1
		else
			if w=2 then
				create w2.default_create
				result:= w2
			else
				create w3.default_create
				result:= w3
			end

		end
	end

end
