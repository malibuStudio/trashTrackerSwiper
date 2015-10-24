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
      "description": obj.description or "쓰레기님이 탄생하셨습니다."
      "imageUrl": obj.url
      "publicId": obj.publicId
      "geometry":
        "type": "Point"
        "coordinates": [obj.geo.coords.longitude, obj.geo.coords.latitude]
        "coordinates": [126.5300577, 33.5001804]
        "timestamp": obj.geo.timestamp or +new Date()
    ,
      validate: false

  'addComment': (comment)->
    object = {}
    object.description = comment.description if comment.description
    object.imageUrl = comment.imageUrl if comment.imageUrl
    object.geometry = comment.geometry if comment.geometry
    Trashes.update comment.parentId,
      $addToSet:
        comments: object
    ,
      validate: false

