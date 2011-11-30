class Conference
	constructor: (@name, @price, location) ->
		geocoder = new google.maps.Geocoder
		geocoder.geocode {address: location}, (results, status) =>
			if status is google.maps.GeocoderStatus.OK
				@longitude = results[0].geometry.location.lng()
				@latitude = results[0].geometry.location.lat()
				@isInitialized = true
				console.log this.longitude
			else
				alert "Unable to query service for address \"#{location}\""

class ConferenceSpreadsheetParser

ConferenceSpreadsheetParser.parse = (spreadsheet, callback) ->
	result = []
	i = 1
	while spreadsheet['A' + i]
		name = spreadsheet['A' + i]
		price = parseInt spreadsheet['B' + i]
		location = spreadsheet['C' + i]
		result.push new Conference name, price, location
		i++
	
	checker = ->
		if ConferenceSpreadsheetParser.hasInitialized result
			clearInterval intervalId
			callback result
	
	intervalId = setInterval checker, 200

ConferenceSpreadsheetParser.hasInitialized = (conferences) ->
	conferences.every (conference) -> conference.isInitialized