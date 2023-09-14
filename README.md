# Friendzone

Friendzone is an app social media like the facebook but it is small app. :shipit:
With a focus on essential features reminiscent of Facebook, our platform enables users to create profiles, connect with friends, share updates and media, and engage in real-time interactions.  Join us to experience a familiar yet innovative social experience that brings people closer together



![friendzone-cover](https://github.com/anhhieu21/friendzone/assets/90468680/60d4efdb-4954-4472-8e63-9fb1955a9123)



## Getting Started

### Flutter
- Version : v3.10.4
- Dart : v3.0.3
- State management :
  `Bloc` https://bloclibrary.dev/#/
- Router :
  `Go router` https://docs.page/csells/go_router/getting-started
### Set up firebase
- https://console.firebase.google.com
- Add project.
- Config project with project firebase.
- Firestore :
  main colection ( `post` , `stories`, `users` ).
- Authencation
- Storage
## Feature
### Auth screen:
  - Login user account, login with google account
  - Register with email
### Main screen:
  - :joystick: Nav-bar-bottom : navigate [ home, reels, chat, friend search, profile ] 
  - :newspaper: Home screen:
      - App bar : you can go write-post screen, follow notification
      - :memo: Navigate to write-post screen: create your post here text, file ( image or video) , use can up multiple file, emoji
      - Bellow of app bar :
          - :camera: Stories : up post show limit in 24h
          - List post [ page , user ] : the post every-one is show here
  - :clapper: Reels screen:
      - Create reel ( video )
      - Here show short-video of user
      - Can like, create comment in reel
  - :left_speech_bubble: Chat screen:
  - :people_holding_hands: Friend-search screen:
  - :mechanic: Profile screen:
## Structure
```bash
.
└── lib
    ├── src
    │   ├── config
    │   │   ├── routes
    │   │   └── themes
    │   ├── data
    │   │   ├── datasource
    │   │   ├── repositories
    │   │   └── services
    │   ├── domain
    │   │   └── model
    │   ├── presentation
    │   │   ├── states
    │   │   ├── views
    │   │   └── widgets
    │   └── utils
    │       ├── constants
    │       ├── extentions
    │       └── l10n
    └── main
