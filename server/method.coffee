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
        "timestamp": obj.geo.timestamp or +new Date()
    , validate: false

  'addComment': (comment)->
    object = {}
    object.description = comment.description if comment.description
    object.imageUrl = comment.imageUrl if comment.imageUrl
    object.geometry = comment.geometry if comment.geometry

    console.log object

    Trashes.update comment.parentId,
      $addToSet:
        comments: object
    , validate: false


