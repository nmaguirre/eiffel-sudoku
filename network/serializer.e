note
	description: "Summary description for {SERIALIZER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SERIALIZER

inherit
	ANY

create
	default_create

feature -- Methods

serialize (a_object: ANY): STRING
		-- Serialize `a_object'.
	require
		a_object_not_void: a_object /= Void
	do
		
	ensure
		serialize_not_void: Result /= Void
	end

deserialize (a_string: STRING): ANY
		-- Deserialize `a_string'.
	require
		a_string_not_void: a_string /= Void
	do

	end

end
