note
	description	: ""
	author		: "Pablo Marconi, Farias Pablo, Dario Astorga, Matias Alvarez, Diego Gastaldi"
	date		: "27/09/2013"
	revision	: "v0.1"
class
	RANDOM_NUMBER

	create
		make

	feature -- Initialization
		make
			local
				l_time : TIME
				l_seed : INTEGER
			do
				create l_time.make_now
      			l_seed := l_time.hour
      			l_seed := l_seed * 60 + l_time.minute
      			l_seed := l_seed * 60 + l_time.second
      			l_seed := l_seed * 1000 + l_time.milli_second
      			create random_sequence.set_seed (l_seed)

			end

feature -- Access
		random_integer : INTEGER
		do
			random_sequence.forth
			Result := random_sequence.item \\ 9 + 1
		end

feature --Implementation
	random_sequence : RANDOM

invariant
	random_obtained: random_sequence /= Void
end
