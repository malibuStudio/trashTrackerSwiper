Meteor.methods
  'insertAnyLocation': (obj)->
    ## Test location
    # navigator.geolocation.getCurrentPosition(function(result) {
    #   console.log(result.coords.longitude);
    #   Meteor.call('insertAnyLocation',{
    #     coords:{
    #       longitude:result.coords.longitude,
    #       latitude:result.coords.latitude
    #     },
    #     timestamp:result.timestamp
    #   });
    # }, function(result) { console.log("error", result) });
    Trashes.insert
      "description": "테스트 위치 Insert"
      "imageUrl": obj.url
      "pulicId": obj.publicId
      "geometry":
        "type": "Point"
        "coordinates": [obj.geo.coords.longitude, obj.geo.coords.latitude]
        "timestamp": obj.geo.timestamp
  'addTrash': (obj)->
    Trashes.insert
      "description": obj.description or "Test 위치 insert"
      "imageUrl": obj.url
      "publicId": obj.publicId
      "geometry":
        "type": "Point"
        "coordinates": [obj.geo.coords.longitude, obj.geo.coords.latitude]
        "timestamp": obj.geo.timestamp
