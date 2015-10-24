Template.upload.events
  'touchend .btn-cropper-close': (e)->
    e.preventDefault()

    TweenMax.to '.upload-container', 0.5,
      opacity: 0
      y: '100%'
      clearProps: 'all'
      onComplete: ->
        $('.upload-container').css('display', 'none')
        $('img.crop-target').cropper('destroy')
        Session.set('commentPhotoUpload', false)
        Session.set('croppedImg')
        Session.set('currentImg')



  'touchend .btn-upload-cropped': (e)->
    e.preventDefault()

    $('.btn-upload-cropped').addClass('loading')

    croppedImg = $('img.crop-target').cropper('getCroppedCanvas', {width: 800, height: 800})

    Session.set('croppedImg', croppedImg.toDataURL())

    cropped = Session.get('croppedImg')


    Cloudinary._upload_file cropped, {}, (err, res) ->
      if err
        # Show Error in console, then remove loading state
        console.log err
        $('.btn-upload-cropped').removeClass('loading')
      else
        Session.set('croppedImg')
        Session.set('currentImg')
        console.log 'Cloudinary Complete: ', res

        geoloc = Geolocation.currentLocation()

        obj =
          url: res.url
          publicId: res.public_id
          geo:
            coords:
              longitude: geoloc.coords.longitude
              latitude: geoloc.coords.latitude
            timestamp: geoloc.timestamp


        if Session.get('commentPhotoUpload') is true
          obj =
            parentId: Session.get('commentParentId')
            imageUrl: res.url
            # description: $.trim($('textarea.comment-text').val())

          Meteor.call 'addComment', obj, (err, res)->
            if err
              console.log ':( ', err.reason
              $('.btn-upload-cropped').removeClass('loading')
            else
              console.log 'Yay!'
              $('textarea.comment-text').val('')
              Session.set('commentPhotoUpload', false)
              $('.btn-upload-cropped').removeClass('loading')
              TweenMax.to '.upload-container', 0.5,
                opacity: 0
                y: '100%'
                clearProps: 'all'
                onComplete: ->
                  $('.upload-container').css('display', 'none');
                  # Session.set('croppedImg')
                  # Session.set('currentImg')

        else
          Meteor.call 'addTrash', obj, (err, res)->
            if err
              console.log err.reason
              $('.btn-upload-cropped').removeClass('loading')
            else
              console.log 'done'
              $('.btn-upload-cropped').removeClass('loading')
              TweenMax.to '.upload-container', 0.5,
                opacity: 0
                y: '100%'
                clearProps: 'all'
                onComplete: ->
                  $('.upload-container').css('display', 'none');
                  # Session.set('croppedImg')
                  # Session.set('currentImg')

