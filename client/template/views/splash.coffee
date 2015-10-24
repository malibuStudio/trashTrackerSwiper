Template.splash.events
  'touchstart .splash-container': (e)->

    console.log 'hello! You\'ve found an easter egg'

    img = document.createElement('img')
    img.src = "/img/splash/Jeju_assets-06.png"
    img.classList.add 'bullet'

    document.querySelector('.splash-inner').appendChild(img)

    placement =
      left: e.clientX or e.originalEvent.touches[0].pageX
      top:  e.clientY or e.originalEvent.touches[0].pageY
      rotate: -720 + ~~(Math.random() * 360)

    console.log placement.rotate

    TweenMax.fromTo img, 1.3,
      opacity: 0
      left: placement.left
      # top: placement.top
      top: ~~(Math.random() * 10)
      scale: 1
      rotation: 360
    ,
      opacity: 1
      left: placement.left
      # left: '50%'
      # top: '50%'
      top: '100%'
      scale: 1
      ease: Bounce.easeOut
      rotation: placement.rotate
      # clearProps: 'all'




    # TweenMax.fromTo '.bullet', 0.8,
    #   opacity: 0
    #   left: placement.left
    #   top: placement.top
    #   scale: 4
    #   rotation: 360
    # ,
    #   opacity: 1
    #   left: '50%'
    #   top: '50%'
    #   scale: 1
    #   ease: Power1.easeOut
    #   rotation: -720
    #   clearProps: 'all'


