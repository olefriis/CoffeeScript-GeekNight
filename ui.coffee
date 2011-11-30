$ ->
	localStorage.clear()
	googleSpreadsheet = new GoogleSpreadsheet()
	googleSpreadsheet.url "0AkHpzadx2wordERkOGROYlpNNkJhVkFrQWpWR0VMYUE"
	googleSpreadsheet.load (result) ->
		ConferenceSpreadsheetParser.parse result.cells, (conferences) ->
			map = new google.maps.Map $("#map-canvas")[0], 
				zoom: 1
				mapTypeId: google.maps.MapTypeId.ROADMAP
			map.setCenter new google.maps.LatLng(0, 0)

			addMarker = (long, lat) ->
				new google.maps.Marker 
					position: new google.maps.LatLng lat, long
					map: map
	
			do ->
				for data in conferences
					do (data) ->
						data.tick = addMarker data.longitude, data.latitude
						google.maps.event.addListener data.tick, "click", (mouseEvent) -> 
							console.log "Clicked #{data.name}"

			updatePriceLabelAndTicks = (lo, hi) ->
				$("#price").val("$#{lo} - #{hi}")
				data.tick.setVisible lo <= data.price <= hi for data in conferences

			$("#slider-range").slider 
				range: true
				min:   0
				max:  20
				values: [5, 11]
				slide: (_, ui) -> updatePriceLabelAndTicks ui.values[0], ui.values[1]
			updatePriceLabelAndTicks $("#slider-range").slider("values", 0), $("#slider-range").slider("values", 1)