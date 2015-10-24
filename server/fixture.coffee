@setFixture = ->
  Meteor.users.remove {}
  userId = Accounts.createUser
    username: 'admin'
    email: 'cleanjeju@malibu-apps.com'
    password: '1234qwer'

  console.log "admin created", userId
  fixtures = [
    description: "돌 샌드위치"
    imageUrl: "http://placehold.jp/3d4070/ffffff/300x300.png?text=1"
#    imageUrl: "./img/fixtures/IMG_2763.JPG"
    geometry:
      type: "Point"
      coordinates: [ 126.7592, 33.5585 ]
      timestamp: 1445613400511
    comments: [
      description: "1st comment"
      createdUserId: userId
    ]
  ,
    description: "모래 은닉자"
    imageUrl: "http://placehold.jp/3d4070/ffffff/300x300.png?text=2"
#    imageUrl: "./img/fixtures/IMG_2765.JPG"
    geometry:
      type: "Point"
      coordinates: [ 126.7594, 33.558 ]
      timestamp: 1445623410511
  ,
    description: "3어른이 흘리지 말아야할 것은 눈물뿐만이 아닙니다"
    imageUrl: "http://placehold.jp/3d4070/ffffff/300x300.png?text=3"
#    imageUrl: "./img/fixtures/IMG_2768.JPG"
    geometry:
      type: "Point"
      coordinates: [ 126.5297, 33.5063 ]
      timestamp: 1445643430511
  ,
    description: "4쓰레기도 돈이다"
    imageUrl: "http://placehold.jp/3d4070/ffffff/300x300.png?text=4"
#    imageUrl: "./img/fixtures/IMG_2778.JPG"
    geometry:
      type: "Point"
      coordinates: [ 126.5297, 33.5063 ]
      timestamp: 1445643430511
  ,
    description: "5쓰레기도 돈이다"
    imageUrl: "http://placehold.jp/3d4070/ffffff/300x300.png?text=5"
#    imageUrl: "./img/fixtures/IMG_2778.JPG"
    geometry:
      type: "Point"
      coordinates: [ 126.5397, 33.5263 ]
      timestamp: 1445643430511
  ,
    description: "제주도가 더러워지고 있다."
    imageUrl: "./img/fixtures/1.jpg"
    geometry:
      type: "Point"
      coordinates: [ 126.4348, 33.4830 ]
      timestamp: 1445623410511
  ,

    description: "쓰레기 탄생"
    imageUrl: "./img/fixtures/2.jpg"
    geometry:
      type: "Point"
      coordinates: [ 126.3235, 33.4532 ]
      timestamp: 1445623410511
  ,

    description: "이런 비양심들..다수의 쓰레기발견!!!"
    imageUrl: "./img/fixtures/3.jpg"
    geometry:
      type: "Point"
      coordinates: [ 126.2535, 33.4028 ]
      timestamp: 1445623410511
  ,

    description: "너무하네요..."
    imageUrl: "./img/fixtures/4.jpg"
    geometry:
      type: "Point"
      coordinates: [ 126.2557, 33.3821 ]
      timestamp: 1445623410511
  ,

    description: "서쪽끝에서 ~~ "
    imageUrl: "./img/fixtures/5.jpg"
    geometry:
      type: "Point"
      coordinates: [ 126.1766, 33.2909 ]
      timestamp: 1445623410511
  ,

    description: "중문단지 쓰레기더미들 우호호ㅎ8 "
    imageUrl: "./img/fixtures/6.jpg"
    geometry:
      type: "Point"
      coordinates: [ 126.3270, 33.2456 ]
      timestamp: 1445623410511
  ,
    description: "제주 남쪽에 쓰레기 많던데요?"
    imageUrl: "./img/fixtures/7.jpg"
    geometry:
      type: "Point"
      coordinates: [ 126.4828, 33.2347 ]
      timestamp: 1445623410511
  ,
    description: "쓰레기버린사람 처벌합시다! "
    imageUrl: "./img/fixtures/8.jpg"
    geometry:
      type: "Point"
      coordinates: [ 126.6380, 33.2674 ]
      timestamp: 1445623410511
  ,
    description: "쓰레기버린사람 아예 사형합시다! "
    imageUrl: "./img/fixtures/9.jpg"
    geometry:
      type: "Point"
      coordinates: [ 126.6980, 33.2684 ]
      timestamp: 1445623410511
  ,
    description: "제주도가 이상해지고 있다."
    imageUrl: "./img/fixtures/1.jpg"
    geometry:
      type: "Point"
      coordinates: [ 126.4348, 33.4830 ]
      timestamp: 1445623410511
  ,

    description: "쓰레기 자꾸 자꾸 탄생하네요"
    imageUrl: "./img/fixtures/2.jpg"
    geometry:
      type: "Point"
      coordinates: [ 126.3235, 33.4532 ]
      timestamp: 1445623410511
  ,

    description: "어떻게하면 좋나요?!!"
    imageUrl: "./img/fixtures/3.jpg"
    geometry:
      type: "Point"
      coordinates: [ 126.2535, 33.4028 ]
      timestamp: 1445623410511
  ,

    description: "제발 이러지 맙시다..."
    imageUrl: "./img/fixtures/4.jpg"
    geometry:
      type: "Point"
      coordinates: [ 126.2557, 33.3821 ]
      timestamp: 1445623410511
  ,

    description: "완전 더러움 ~~ "
    imageUrl: "./img/fixtures/5.jpg"
    geometry:
      type: "Point"
      coordinates: [ 126.1766, 33.2909 ]
      timestamp: 1445623410511
  ,

    description: "중문입니다 신라호텔 부근 우호호ㅎ8 "
    imageUrl: "./img/fixtures/6.jpg"
    geometry:
      type: "Point"
      coordinates: [ 126.3270, 33.2456 ]
      timestamp: 1445623410511
  ,
    description: "제주해안의 쓰레기문제 심각하다!!!!!!!!!!"
    imageUrl: "./img/fixtures/7.jpg"
    geometry:
      type: "Point"
      coordinates: [ 126.4828, 33.2347 ]
      timestamp: 1445623410511
  ,
    description: "우왕 이거좀 이제 처벌합시다! "
    imageUrl: "./img/fixtures/8.jpg"
    geometry:
      type: "Point"
      coordinates: [ 126.6380, 33.2674 ]
      timestamp: 1445623410511
  ,

    description: "벌금형 시급합니다 어서요! "
    imageUrl: "./img/fixtures/9.jpg"
    geometry:
      type: "Point"
      coordinates: [ 126.6980, 33.2684 ]
      timestamp: 1445623410511
  ]
  Trashes.insert (_.extend fixture, createdAt: new Date(fixture.geometry.timestamp), createdUserId: userId), validate: false for fixture in fixtures