Meteor.methods
  'insertAnyLocation': (obj)->
  'addTrash': (obj)->
    Trashes.insert
      "description": obj.description or "쓰레기님이 탄생하셨습니다."
      "imageUrl": obj.url
      "publicId": obj.publicId
      "geometry":
        "type": "Point"
        "coordinates": [obj.geo.coords.longitude, obj.geo.coords.latitude]
<<<<<<< HEAD
        "timestamp": obj.geo.timestamp
    , validate: false
=======
        "timestamp": obj.geo.timestamp or +new Date()
    ,
      validate: false
>>>>>>> afce4fc42b2b6fc7d1d117bfb45ba72f3f77ddd1

  'addComment': (comment)->
    object = {}
    object.description = comment.description if comment.description
    object.imageUrl = comment.imageUrl if comment.imageUrl
    object.geometry = comment.geometry if comment.geometry
    Trashes.update comment.parentId,
      $addToSet:
        comments: object
<<<<<<< HEAD
    , validate: false
=======
    ,
      validate: false
>>>>>>> afce4fc42b2b6fc7d1d117bfb45ba72f3f77ddd1

