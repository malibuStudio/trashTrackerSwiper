@Trashes = new Mongo.Collection 'trashes'

@Schemas = {}

@Schemas.Coordinate = new SimpleSchema
  "type":
    type: String
    autoValue: ->
      "Point"
  "coordinates":
    type: [Number]
  "timestamp":
    type: Number
@Schemas.Trashes = new SimpleSchema
  "description":
    type: String
    label: "description"
    optional: true
    max: 200
  "imageUrl":
    type: String
    label: "imageUrl"
  "publicId":
    type: String
    label: "publicId"
  "geometry":
    type: Schemas.Coordinate
  "createdAt":
    type: Date
    denyUpdate: true
    autoValue: ->
      if @isInsert
        new Date
  "createdUserId":
    type: String
    denyUpdate: true
    autoValue: ->
      if @isInsert
        @value and @value or @userId
  "createdUserName":
    type: String
    autoValue: (doc)->
      if @isInsert
        Meteor.users.findOne(doc and doc.createdUserId or @userId).username
    denyUpdate: true
  # comments array
  "comments":
    type: [Object]
    optional: true
  "comments.$._id":
    type: String
    autoValue: ->
      if @isUpdate and not @value
        Random.id()
  "comments.$.description":
    type: String
    max: 200
    optional: true
  "comments.$.imageUrl":
    type: String
    optional: true
  "comments.$.geometry":
    type: SimpleSchema.Coordinate
    optional: true
  "comments.$.createdUserId":
    type: String
    autoValue: ->
      @value and @value or @userId
  "comments.$.createdUserName":
    type: String
    autoValue: (doc)->
      # needs better practice
      Meteor.users.findOne(doc.comments and doc.comments[0].createdUserId or @userId).username
  "comments.$.createdAt":
    type: Date
    autoValue: ->
      @value and @value or new Date


Trashes.attachSchema Schemas.Trashes