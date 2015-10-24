Template.upload.events
  'touchend .btn-upload-cropped': (e)->
    e.preventDefault()

    $('.btn-upload-cropped').addClass('loading')

    croppedImg = $('img.crop-target').cropper('getCroppedCanvas', {width: 800, height: 800})

    Session.set('croppedImg', croppedImg.toDataURL())

    cropped = Session.get('croppedImg')

    # DUMMY TEST
    # dummyCoords =
    #   coords:
    #     longitude: 133
    #     latitude: 32
    # Meteor.call 'insertAnyLocation', dummyCoords, (err, res)->
    #   if err
    #     console.log err.reason
    #     $('.btn-upload-cropped').removeClass('loading')
    #   else
    #     console.log res
    #     $('.btn-upload-cropped').removeClass('loading')

    Cloudinary._upload_file cropped, {}, (err, res) ->
      if err
        # Show Error in console, then remove loading state
        console.log err
        $('.btn-upload-cropped').removeClass('loading')
      else
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



        Meteor.call 'insertAnyLocation', obj, (err, res)->
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
                  $('.upload-container').style('display', 'none');

