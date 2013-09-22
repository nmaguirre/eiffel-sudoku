note
	description: "ARRAY of the five best player {TOP_FIVE}."
	author: "Justine Compagnon"
	date: "22/09/2013"
	revision: "NONE"

class
	TOP_FIVE

inherit
	STORABLE

	ARRAY[INTEGER]
	undefine
		is_equal,copy
	end

create
	init

feature {ANY} --Initialize
	init
	do
		--empty
	end

feature {NONE}  --main variable


end
