note
	description: "Summary description for {TOP_FIVE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

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

end
