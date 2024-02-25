# Friendzone

Friendzone is an app social media like the facebook but it is small app. :shipit:
With a focus on essential features reminiscent of Facebook, our platform enables users to create profiles, connect with friends, share updates and media, and engage in real-time interactions.  Join us to experience a familiar yet innovative social experience that brings people closer together


## Light Mode 
![friendzone-cover](https://github.com/anhhieu21/friendzone/assets/90468680/c811e516-a115-4813-80b5-91be1b0f8447)

## Dark Mode

## Getting Started
### Flutter
- Version : v3.16.9
- Dart : v3.2.6
- State management :
  `Bloc` https://bloclibrary.dev/#/
- Router :
  `Go router` https://docs.page/csells/go_router/getting-started
### Set up firebase
- https://console.firebase.google.com
- Add project.
- Config project with project firebase.
- Firestore :
  main colection ( `post`, `reel`, `stories`, `users` ).
- Authencation
- Storage
## Feature
### Auth screen:
  - Login user account, login with google account
  - Register with email
### Main screen:
  - :joystick: Nav-bar-bottom : navigate [ home, reels, friend search, profile ] 
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
      - Chat with your friends
  - :people_holding_hands: Friend-search screen:
  - :mechanic: Profile screen:
      - Edit your info
      - Upload your avatar and cover
      - All your post in here
      - Again enjoy post saved
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
