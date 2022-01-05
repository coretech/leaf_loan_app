# Leaf Loan App

[![Codemagic build status](https://api.codemagic.io/apps/617fa4d801bcda9fc6054f2a/617fa4d801bcda9fc6054f29/status_badge.svg)](https://codemagic.io/apps/617fa4d801bcda9fc6054f2a/617fa4d801bcda9fc6054f29/latest_build)

Leaf Loans allows Leaf customers to apply for, obtain, and pay off microloans. It works in conjunction with Leaf’s core wallet to support the storage and transport of assets across borders.

This repo contains the source code for the Leaf Loans mobile app.

We use Flutter and we follow clean architecture to allow for easy scalability and migration. Since the Leaf Loan app is still a work in progress, having loose coupling between the app logic and third party libraries gives us a much needed flexibility to try different approaches.

# Prerequisites

- Make sure you have [Flutter](https://flutter.dev) installed.
- Create a Firebase project and obtain a Google Services configuration file for iOS or Android. This is mandatory to run the app. You can follow the instruction here on how to obtain the [Firebase Config File](https://firebase.google.com/docs/flutter/setup?platform=ios#add-config-file). You should then add them in the respective directories. In `ios/` for the iOS version and in `android/app/` for Android.
- We also use [Credo Lab's](https://www.credolab.com/) services to get information about our users' phone usage behaviors. You should get an **Authentication key** and **Endpoint URL** to allow the pull to happen.
- After obtaining the Credo credentials, add the following values to your **launch.json** under the **"configurations"** in VS Code.

          {
              "args": [
                  "--dart-define",
                  "CREDO_AUTH_KEY=CREDO_AUTH_KEY",
                  "--dart-define",
                  "CREDO_URL=CREDO_URL"
              ],
              "name": "loan_app",
              "request": "launch",
              "type": "dart",
          }

  You can use the equivalent setup on Android Studio.

If you run the app from terminal, you can pass the arguments as follows

```sh
flutter run --dart-define CREDO_AUTH_KEY=CREDO_AUTH_KEY --dart-define CREDO_URL=CREDO_URL
```

# Installing

- In the terminal type `flutter pub get` to install all required packages

# Contributing

If you want to contribute to the project, check out our [Contribution Guidelines](https://github.com/LeafGlobalFintech/loan_app/blob/develop/CONTRIBUTING.md)

# Documentation

You can find the full documentation [here](https://leafglobalfintech.github.io/docs/leaf-loans/intro/)
