$(window).resize( ->
  h = $(window).height()
  offsetTop = 0
  $mc = $("#map")
  $mc.css 'height', h- offsetTop
).resize()

Template.map.onCreated ->
  navigator.geolocation.getCurrentPosition (loc)=>
    @locationSubs and @locationSubs.stop()
    @locationSubs = @subscribe 'getTrashLocations', [
      loc.coords.longitude,
      loc.coords.latitude
    ]

@origin =
  longitude: 126.54
  latitude: 33.398633
Template.map.onRendered ->
#  navigator.geolocation.getCurrentPosition (location)=>
#  console.log 'map rendered'
#  @map = L.map('map',
#    minZoom: 9
#    maxZoom: 9
#    dragging: false
#    boxZoom: false
#    touchZoom: false
#    scrollWheelZoom: false
#    zoomControl: false
#    attributionControl: false
#  ).setView [
#    @view.template.origin.latitude, @view.template.origin.longitude
#  ], 9
#  getColor = (d)->
#    d > 4 and '#800026' or
#    d > 3 and '#BD0026' or
#    d > 2 and '#E31A1C' or
#    d > 1 and '#FC4E2A'
#
#  L.geoJson(jejuMap, style: (feature)->
#    console.log feature.properties.density
#    fillColor: getColor feature.properties.density
#    weight: 2
#    opacity: 1
#    color: 'white'
#    dashArray: '3'
#    fillOpacity: 0.7
#  ).addTo(@map)

Template.map.helpers
  'trashes': (e, tmpl)->
    t = Template.instance()
    maxDensity = 0
    # go reactive
    trashes = Trashes.find().map (v)-> v.geometry.coordinates
    unless trashes.length
      return []
    for feature in jejuMap.features
      density = 0
      for trash in trashes
        if GeoJSON.pointInPolygon({
            'type': 'Point'
            'coordinates': trash
          },
          'type': 'Polygon'
          'coordinates': feature.geometry.coordinates )
          density++
      feature.properties.density = density
      maxDensity = maxDensity < density and density or maxDensity
      console.log 'density', density
#    console.log 'trashes found'
#    console.log jejuMap.features

    console.log 'map rendered'
    console.log 'maxDensity', maxDensity
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
      origin.latitude, origin.longitude
    ], 9

    getColor = (d)->
      d = d / maxDensity * 8
      d > 7 and '#800026' or
      d > 6 and '#BD0026' or
      d > 5 and '#E31A1C' or
      d > 4 and '#FC4E2A' or
      d > 3 and '#FD8D3C' or
      d > 2 and '#FEB24C' or
      d > 1 and '#FED976' or
      '#FFEDA0'

    style = (feature)->
      console.log 'getColor', getColor feature.properties.density
      fillColor: getColor feature.properties.density
      weight: 2
      opacity: 0.7
      color: 'purple'
      dashArray: '3'
      fillOpacity: 0.7
    L.geoJson(jejuMap, style: style).addTo(@map)

    jejuMap.features.sort (a,b)->
      a.properties.density > b.properties.density and -1 or
      a.properties.density is b.properties.density and 0 or
      a.properties.density < b.properties.density and 1
