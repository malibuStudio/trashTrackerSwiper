Template.page.onCreated ->
#  @pageIndex = new ReactiveVar 1
  navigator.geolocation.getCurrentPosition (loc)=>
    @locationSubs and @locationSubs.stop()
    @locationSubs = @subscribe 'getTrashLocations', [
      loc.coords.longitude,
      loc.coords.latitude
    ]
  @touchstart =
    x: 0
    y: 0
  @comments = new Mongo.Collection null

Template.page.helpers
  "checkedClass": ->
    userId = Meteor.userId()
    if userId and @lgtmUsers and userId in @lgtmUsers
      return 'voted'
    else
      return 'vote'
  "Trashes": ->
    # t = Template.instance()
    # idx = t.pageIndex.get()
    # debugger
    Trashes.find {},
      sort:
        createdAt: -1
  "comments": ->
    t = Template.instance()
    trashId = Session.get('commentParentId')
    if trashId?
      t.comments.remove {}
      trash = Trashes.findOne(trashId)
      if trash and trash.comments
        t.comments.insert comment for comment in trash.comments
      t.comments.find {},
        sort:
          createdAt: -1
  "gestures":
    'swiperight .page-container': (e, tmpl)->
      e.preventDefault()
      # tmpl.view.template.swipeH -1, tmpl
    'swipeleft .page-container': (e, tmpl)->
      e.preventDefault()
      # tmpl.view.template.swipeH 1, tmpl

Template.page.events
  # ========================================================
  # Comments
  # -> Layout Control
  # ========================================================
  'touchend [data-action=show-comment], touchend .goto-list': (e)->
    e.preventDefault()

    if 'view-comments' in document.querySelector('.page-comments').classList
      TweenMax.to '.page-comments', 0.3,
        x: '100%'
        ease: Power4.easeOut
        clearProps: "all"
        onComplete: ->
          document.querySelector('.page-comments').classList.remove 'view-comments'
    else
      Session.set('commentParentId', @_id)
      TweenMax.to '.page-comments', 0.3,
        x: 0
        ease: Power4.easeOut
        onComplete: ->
          document.querySelector('.page-comments').classList.add 'view-comments'

  # ========================================================
  # Comments
  # -> LGTM
  # ========================================================
  'touchend .vote': (e)->
    e.preventDefault()
    e.stopImmediatePropagation()

    obj =
      trashId: Session.get('commentParentId')
      commentId: @_id

    Meteor.call "checkLGTM", obj
    return false

  'touchend .voted': (e)->
    e.preventDefault()
    e.stopImmediatePropagation()

    obj =
      trashId: Session.get('commentParentId')
      commentId: @_id

    Meteor.call "uncheckLGTM", obj
    return false


  # ========================================================
  # Comments
  # -> Upload Text Comment
  # ========================================================
  'touchend .bottom-bar button.comment-submit': (e)->
    e.preventDefault()
    if Meteor.userId()
      obj =
        parentId: Session.get('commentParentId')
        description: $.trim($('textarea.comment-text').val())

      Meteor.call 'addComment', obj, (err, res)->
        if err
          console.log ':( ', err.reason
        else
          console.log 'Yay!'
          $('textarea.comment-text').val('')
    else
      console.log 'Sign in required'
      MODAL('modal-account')

  # ========================================================
  # Comments
  # -> Upload Comment Photo
  # ========================================================
  'change #upload-comment-photo': (e)->
    Session.set('commentPhotoUpload', true)
    e = e.originalEvent
    target = e.dataTransfer or e.target
    file = target and target.files and target.files[0]
    options =
      canvas: true
      maxWidth: 800

    if not file
      return
    else
      console.log 'File: ', file
      # if file.size > 4194304
      #   return false

      # Use the "JavaScript Load Image" functionality to parse the file data
      loadImage.parseMetaData file, (data) ->

        # Get the correct orientation setting from the EXIF Data
        if data.exif
          options.orientation = data.exif.get('Orientation')
          if data.exif.map
            console.log 'Exif.map: ',data.exif.map
          else
            console.log 'Location Data does not Exist'

        # Load the image from disk and inject it into the DOM with the correct orientation
        loadImage file, ((canvas) ->
          imgDataURL = canvas.toDataURL('img/jpg')

          Session.set('currentImg', imgDataURL)

          $('img.crop-target').attr(
            'src': Session.get('currentImg')
          )

          $('.upload-container').css('display', 'block');
          Meteor.setTimeout (->
            TweenMax.to '.upload-container', 0.5,
              opacity: 1
              y: 0
          ), 500

          $('img.crop-target').imagesLoaded().done (instance)->
            console.log 'Image Done'
            Meteor.setTimeout (->
              $('img.crop-target').cropper
                aspectRatio: 1/1
                guides: false
                strict: true
                dragCrop: false
                cropBoxMovable: true
                cropBoxResizable: true
                responsive: true
                mouseWheelZoom: true
                built: ->
                  TweenMax.to '.malibu-crop-wrapper', 0.5,
                    opacity: 1
                    onComplete: ->
                      console.log 'Tween'
            ), 1000

        ), options


  # ========================================================
  # Events
  # -> Layout Control
  # ========================================================
  'touchstart .swiper-container': (e)->
    firstTouch = e.originalEvent.touches[0]

    Template.instance().touchstart =
      x: firstTouch.pageX
      y: firstTouch.pageY

  'touchend .swiper-container': (e)->
    lastTouch = e.originalEvent.changedTouches[e.originalEvent.changedTouches.length-1]

    touchend =
      x: lastTouch.pageX
      y: lastTouch.pageY

    touchstart = Template.instance().touchstart

    uiWrapper = document.getElementById('ui-wrapper')

    # # Show touchstart and touchend obj (x, y)
    # console.log 'touchstart', touchstart
    # console.log 'touchend', touchend

    if _.isEqual(touchstart, touchend)
      console.log 'tap not move'
      if 'active' in uiWrapper.classList
        console.log 'menu visible'
        TweenMax.to uiWrapper, 0.5,
          opacity: 0
          onComplete: ->
            uiWrapper.classList.remove 'active'
            uiWrapper.style.pointerEvents = 'none'
      else
        console.log 'menu hidden'
        TweenMax.to uiWrapper, 0.5,
          opacity: 1
          onComplete: ->
            uiWrapper.classList.add 'active'
            uiWrapper.style.pointerEvents = 'auto'

# ========================================================
# Events
# -> Upload Photo
# ========================================================
  'touchend #upload-photo': (e)->
    if not Meteor.userId()
      console.log 'Sign in required'
      MODAL('modal-account')

  'change #upload-photo input': (e)->
    Session.set('commentPhotoUpload', false)
    e.preventDefault
    e = e.originalEvent
    target = e.dataTransfer or e.target
    file = target and target.files and target.files[0]
    options =
      canvas: true
      maxWidth: 800

    if not file
      return
    else
      console.log 'File: ', file
      # if file.size > 4194304
      #   return false

      # Use the "JavaScript Load Image" functionality to parse the file data
      loadImage.parseMetaData file, (data) ->

# Get the correct orientation setting from the EXIF Data
        if data.exif
          options.orientation = data.exif.get('Orientation')
          if data.exif.map
            console.log 'Exif.map: ',data.exif.map
          else
            console.log 'Location Data does not Exist'

        # Load the image from disk and inject it into the DOM with the correct orientation
        loadImage file, ((canvas) ->
          imgDataURL = canvas.toDataURL('img/jpg')

          Session.set('currentImg', imgDataURL)

          $('img.crop-target').attr(
            'src': Session.get('currentImg')
          )

          $('.upload-container').css('display', 'block');
          Meteor.setTimeout (->
            TweenMax.to '.upload-container', 0.5,
              opacity: 1
              y: 0
          ), 500

          $('img.crop-target').imagesLoaded().done (instance)->
            console.log 'Image Done'
            Meteor.setTimeout (->
              $('img.crop-target').cropper
                aspectRatio: 1/1
                guides: false
                strict: true
                dragCrop: false
                cropBoxMovable: true
                cropBoxResizable: true
                responsive: true
                mouseWheelZoom: true
                built: ->
                  TweenMax.to '.malibu-crop-wrapper', 0.5,
                    opacity: 1
                    onComplete: ->
                      console.log 'Tween'
            ), 1000

        ), options

  # ========================================================
  # MAPS
  # -> Layout Control
  # ========================================================
  'touchend .goto-map': (e)->
    e.preventDefault()

    $('.map-container').css('top', 0)

    TweenMax.to '.map-container', 0.5,
      opacity: 1
      onComplete: ->
        $('.map-container').css('pointer-events', 'auto')

  'touchend .close-map': (e)->
    e.preventDefault()

    TweenMax.to '.map-container', 0.5,
      opacity: 0
      onComplete: ->
        $('.map-container').css
          'pointer-events': 'none'
          'top': -9999999

Template.page.onRendered ->
  $('.bottom-bar textarea').autosize()



