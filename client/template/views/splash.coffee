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
      top: ~~(Math.random() * 10)
      scale: 1
      rotation: 360
    ,
      opacity: 1
      left: placement.left
      top: '100%'
      scale: 1
      ease: Bounce.easeOut
      rotation: placement.rotate



Template.splash.onRendered ->
  TweenMax.from '.stripe', 1.2,
    opacity: 0
    y: '22%'
  TweenMax.from 'img.logo', 1,
    opacity: 0
    y: '-100%'
    ease: Bounce.easeOut
  TweenMax.from 'img.halbe', 0.8,
    opacity: 0
    y: '30%'
    delay: 0.4
    ease: Power3.easeOut

  Meteor.setTimeout (->
    TweenMax.to '.stripe', 0.2,
      scale: 1.5
      opacity: 0
    TweenMax.to 'img.logo', 0.2,
      scale: 1.5
      opacity: 0
    TweenMax.to 'img.halbe', 0.2,
      scale: 1.5
      opacity: 0
    TweenMax.to '.splash-container', 0.2,
      opacity: 0
      delay: 0.15
      onComplete: ->
        $('.splash-container').remove()
  ), 3500
