note
	description	: "POST_IT is an array 1..9 of BOOLEAN useful to know which values are possible for a cell"
	author		: "Gabriel Mabille"
	date		: "11/09/13"
	revision	: "NONE"

class
	POSTIT
inherit
	ARRAY[BOOLEAN]
	redefine
		put
	end

create
	init

feature -- Init

	init
	do
		make_filled (True, 1, 9)
	end

feature -- Access

	put(value : BOOLEAN; i : INTEGER)
	require else
		i >= 0 and i <= 9
	do
		Precursor (value, i)
	end

	get_only_value_possible : INTEGER
		-- give the only value possible
	require
		has_only_one_value_possible
	local
		i : INTEGER
		value_found : BOOLEAN
	do
		from
			i := 1
			value_found := False
		until
			i > 9 or value_found
		loop
			if Current.at (i) then
				value_found := True
			end
			i := i + 1
		end
		result := i - 1
	ensure
		result >= 1 and result <= 9
	end

	set_only_value_possible(value : INTEGER)
		-- set the only value possible
	require
		value >= 1 and value <= 9
	local
		i : INTEGER
	do
		from
			i := 1
		until
			i > 9
		loop
			if i /= value then
				Current.put (False, i)
			else
				Current.put (True, i)
			end
			i := i + 1
		end
	end

feature --Info

	has_only_one_value_possible : BOOLEAN
		-- tells if in the postit only one value is available
	local
		i : INTEGER
		number_value : INTEGER
	do
		from
			i := 1
			number_value := 0
		until
			i > 9 or number_value > 1
		loop

			if Current.at (i) then
				number_value := number_value + 1
			end

			i := i+1
		end
		result := (number_value = 1)
	end

feature --Out

	to_string : STRING
	local
		possible_values : STRING
		i : INTEGER
	do
		create possible_values.make_empty
		from
			i := 1
		until
			i > 9
		loop
			if Current[i] then
				possible_values := possible_values + i.out + ": O | "
			else
				possible_values := possible_values + i.out + ": N | "
			end
			i := i + 1
		end
		result := possible_values
	end
end
