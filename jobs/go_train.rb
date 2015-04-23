stouffville_timings_from_schedule = YAML.load(File.read('go_train.yml'))['stouffville']
lakeshore_east_timings_from_schedule = YAML.load(File.read('go_train.yml'))['lakeshore_east']
richmond_timings_from_schedule = YAML.load(File.read('go_train.yml'))['richmond']

TIME_INTERVAL = 2 * 3600 * 1000

SCHEDULER.every '300s', first_in: 0 do
	stouffvilleNextDepartureTimes = []
	lakeshoreEastNextDepartureTimes = []
	richmondNextDepartureTimes = []

	getSchedule(stouffville_timings_from_schedule, stouffvilleNextDepartureTimes)
	getSchedule(lakeshore_east_timings_from_schedule, lakeshoreEastNextDepartureTimes)
	getSchedule(richmond_timings_from_schedule, richmondNextDepartureTimes)

	send_event('go_train', { stouffville: stouffvilleNextDepartureTimes, lakeshoreEast: lakeshoreEastNextDepartureTimes, richmond: richmondNextDepartureTimes })
end

def getSchedule(timingsFromYAML, returnTimings)
	currentTime = Time.new
	currentTime = currentTime.getlocal("-04:00")

	timingsFromYAML.each do |timing|
		scheduledTime = timing['time'].split(':')
		scheduledTimeMinutes = scheduledTime[1].split(' ')

		hour = scheduledTime[0].to_i
		minute = scheduledTimeMinutes[0].to_i

		if scheduledTimeMinutes[1] == 'pm'
			if hour == 12
				hour = 12
			else
				hour = hour + 12
			end
		end

		departureTime = Time.new(currentTime.year, currentTime.month, currentTime.day, hour, minute, 0, "-04:00")
		futureTwoHourTime = Time.new(currentTime.year, currentTime.month, currentTime.day, currentTime.hour + 2, currentTime.min, currentTime.sec, "-04:00")
		diff = (departureTime - currentTime) * 1000

		if currentTime <= departureTime && departureTime <= futureTwoHourTime
			transportType = if  timing['type'] == 'Train' then '(T)' else '(B)' end
			returnTimings.push(timing['time'].sub(' ', '') + ' ' + transportType)
		end
	end

	return returnTimings
end