describe 'ConferenceSpreadsheetParser', ->
  it 'converts lines to conference information', ->
	spreadsheet = {
		'A1': 'YOW! Melbourne'
		'B1': '1500'
		'C1': 'Melbourne, Australia'
		
		'A2': 'GOTO Aarhus'
		'B2': '1700'
		'C2': 'Aarhus, Denmark'
	}
	parsed_conferences = null
	ConferenceSpreadsheetParser.parse spreadsheet, (conferences) -> parsed_conferences = conferences
	waitsFor(-> parsed_conferences isnt null)
	runs ->
		expect(parsed_conferences.length).toBe 2
		expect(parsed_conferences[0].name).toBe 'YOW! Melbourne'
		expect(parsed_conferences[0].price).toBe 1500
		expect(parsed_conferences[0].longitude).toBeCloseTo 144.96, 0.2
		expect(parsed_conferences[0].latitude).toBeCloseTo -37.81, 0.2
