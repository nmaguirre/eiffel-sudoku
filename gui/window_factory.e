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
	do
		if w=1 then
			create w1.default_create
			result:=  w1
		else
			create w2.default_create
			result:= w2
		end
	end

end
