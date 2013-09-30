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
	time_duration:TIME_DURATION

	make
	do
		create initial_time.make_now
		create time_duration.make (0, 0,0)
	end

    -- Method that update time_duration. time_duration has the time pass from initial time until now.
    update_time_duration
    require
    	initial_time_is_void: initial_time /= void
    local
    	actual_time:DATE_TIME
    	add_time: DATE_TIME_DURATION
    	second,min: INTEGER;
	do
		create actual_time.make_now
		add_time:=actual_time.relative_duration(initial_time)
		second:= time_duration.second + add_time.second
		min:=add_time.minute + time_duration.minute + second//60
		time_duration.make (add_time.year*365*24 + add_time.month *30*24+ add_time.day*24+min//60, min\\60, second\\60)
		--time_duration:=time_duration.plus (add_time)
		initial_time:=actual_time
		print("------------------------" + time_duration.second.out+ " "+time_duration.minute.out)
	end

    -- Method that set time_duration.
	set_time_duration(t:TIME_DURATION)
	require
		new_time_duration_void: t /= void
	do
		time_duration:=t
	end

end
