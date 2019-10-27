# Smart Notes
[![Build status](https://dev.azure.com/cross-solutions/eNotes-FlutterPH-Hackathon/_apis/build/status/eNotes-FlutterPH-Hackathon-CI)](https://dev.azure.com/cross-solutions/eNotes-FlutterPH-Hackathon/_build/latest?definitionId=3) [![Generic badge](https://img.shields.io/badge/App%20Center-Install%20Android-<COLOR>.svg)](https://install.appcenter.ms/orgs/cross-solutions/apps/smart-notes-android/distribution_groups/public) [![made-with-Markdown](https://img.shields.io/badge/Made%20with-Flutter-1389FD.svg)](http://flutter.dev) [![Open Source Love svg1](https://badges.frapsoft.com/os/v1/open-source.svg?v=103)]()

<img src="app_screenshot.png" />
<br />
<br />

A note-taking app using Google services such as Google Sign In, Google Drive, and Firebase ML Vision.

This is an entry to FlutterPH's Online Hackathon 2019.


#### Notable Plugins/Technologies Used
- [google_sign_in](https://pub.dev/packages/google_sign_in), [googleapis](https://pub.dev/packages/googleapis), and [googleapis_auth](https://pub.dev/packages/googleapis_auth) for using Google Identity Platform and Google Drive Platform,
- [firebase_ml_vision](https://pub.dev/packages/firebase_ml_vision) for OCR (text recognition).
- [moor_flutter](https://pub.dev/packages/moor_flutter) for a reactive style of persisting data locally using SQLite.
- [scoped_model](https://pub.dev/packages/scoped_model) for state management using MVVM pattern.


#### Running the Project

Please send me an email at dustinboy619@gmail.com with your local Android debug certificate's SHA-1 fingerprint.
We will then give you the `google-services.json` config file needed in order to run the project. Place this in
`src/app/android/app` directory.