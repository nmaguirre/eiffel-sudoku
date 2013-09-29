note
	description: "Class that implements a timer"
	author: "Fernando Raverta"
	date: "$28/9/2013$"
	revision: "$Revision$"

class
	CLOCK

create
	make


feature {ANY}
	initial_time:DATE_TIME
	time_duration:DATE_TIME_DURATION

	make
	do
		create initial_time.make_now
		create time_duration.make (0,0, 0, 0, 0,0)
	end

    -- Method that update time_duration. time_duration has the time pass from initial time until now.
    update_time_duration
    require
    	initial_time_is_void: initial_time /= void
    local
    	actual_time:DATE_TIME
	do
		create actual_time.make_now
		time_duration:= actual_time.relative_duration(initial_time)
	end

    -- Method that set time_duration.
	set_time_duration(t:DATE_TIME_DURATION)
	require
		new_time_duration_void: t /= void
	do
		time_duration:=t
	end
end
