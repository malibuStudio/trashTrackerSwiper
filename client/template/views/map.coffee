$(window).resize( ->
  h = $(window).height()
  offsetTop = 0
  $mc = $("#map")
  $mc.css 'height', h- offsetTop
).resize()

Template.map.origin =
  longitude: 126.54
  latitude: 33.398633
Template.map.onRendered ->
#  navigator.geolocation.getCurrentPosition (location)=>
  console.log "currentLocation", location
  @map = L.map('map',
    minZoom: 9
    maxZoom: 9
    dragging: false
    boxZoom: false
    touchZoom: false
    scrollWheelZoom: false
    zoomControl: false
    attributionControl: false
  ).setView [
    @view.template.origin.latitude, @view.template.origin.longitude
  ], 9
  L.geoJson(jejuMap).addTo(@map)
, (error)->
  console.log "faile to get location", error
