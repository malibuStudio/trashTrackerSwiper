$(window).resize( ->
  h = $(window).height()
  offsetTop = 0
  $mc = $("#map")
  $mc.css 'height', h- offsetTop
).resize()

Template.map.onRendered ->
  navigator.geolocation.getCurrentPosition (location)->
    console.log "currentLocation", location
    @map = L.map('map').setView [location.coords.latitude, location.coords.longitude ], 8
    L.geoJson(jejuMap).addTo(@map)
  , (error)->
    console.log "faile to get location", error
