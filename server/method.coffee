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
    Trashes.update comment.parentId,
      $addToSet:
        comments: object
    , validate: false
  'checkLGTM': (obj)->
    # Meteor.call("checkLGTM", {trashId: "Qtj2uCpg4zkeEfeQP", commentId:"E3LNP9CQtAbp7Pq22"});
    # check users
    comment = _.find Trashes.findOne( obj.trashId ).comments, (v)-> v._id is obj.commentId
    unless comment and comment.lgtmUsers and _.contains comment.lgtmUsers, @userId
      Trashes.update
        _id: obj.trashId
        "comments._id": obj.commentId
      , $inc:
          "comments.$.lgtm": 1
          "lgtm": 1
      , validate: false
      # add User
      Trashes.update
        _id: obj.trashId
        "comments._id": obj.commentId
      , $addToSet:
          "comments.$.lgtmUsers": @userId
      , validate: false
      true # success
    else
      false # fail
  'uncheckLGTM': (obj)->
    comment = _.find Trashes.findOne( obj.trashId ).comments, (v)-> v._id is obj.commentId
    if comment and comment.lgtmUsers and _.contains comment.lgtmUsers, @userId
      Trashes.update
        _id: obj.trashId
        "comments._id": obj.commentId
      , $inc:
        "comments.$.lgtm": -1
        "lgtm": -1
      # remove User
      Trashes.update
        _id: obj.trashId
        "comments._id": obj.commentId
      , $pull:
          "comments.$.lgtmUsers": @userId
      , validate: false
      true # success
    else
      false # fail