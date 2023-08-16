# Friendzone

Friendzone is an app social media like the facebook but it is small app. :shipit:
With a focus on essential features reminiscent of Facebook, our platform enables users to create profiles, connect with friends, share updates and media, and engage in real-time interactions.  Join us to experience a familiar yet innovative social experience that brings people closer together
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
### Structure
```bash
├── app_bloc_observer.dart
├── common
│   ├── constants
│   └── extentions
├── data
│   ├── models
│   └── repositories
├── domain
├── firebase_options.dart
├── main.dart
├── presentation
│   ├── app.dart
│   ├── routes
│   ├── services
│   ├── themes
│   ├── utils
│   ├── view.dart
│   └── views
│       ├── auth
│       │   ├── view
│       │   └── widgets
│       ├── chats
│       │   ├── view
│       │   └── widgets
│       ├── friendzone
│       │   └── view
│       ├── home
│       │   ├── view
│       │   └── widgets
│       ├── post
│       │   ├── view
│       │   └── widgets
│       ├── profile
│       │   ├── view
│       │   └── widgets
│       └── splash
└── state
    ├── auth
    ├── chat
    ├── friend_zone
    ├── home
    │   ├── allpost
    │   ├── feed_cubit
    │   └── post_cubit
    ├── post
    └── profile
        ├── myaccount
        ├── update
        └── user
