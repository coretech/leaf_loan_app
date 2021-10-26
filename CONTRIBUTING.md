
# Contribution guidelines

First of all, thanks for thinking of contributing to this project. :smile:

Before creating a Pull Request, please make sure that you're assigned the task on a GitHub issue. 

- If a relevant issue already exists, discuss on the issue and get it assigned to yourself on GitHub.
- If no relevant issue exists, open a new issue and get it assigned to yourself on GitHub.

Please proceed with a Pull Request only after you're assigned. It'd be sad if your Pull Request (and your hard work) isn't accepted because of incompatibility or someone else already finishing it.

When you start working on the issue, please kindly update the status in the project to `In Progress`

When you create a PR, make sure that you include a bit of description to what the PR introduces to the code base. And if possible, make your PRs as small possible so that we can review and merge it quickly.

When your PR is ready, make sure to request for review from the person who assigned you to the issue.

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

    flutter run --dart-define CREDO_AUTH_KEY=CREDO_AUTH_KEY --dart-define CREDO_URL=CREDO_URL

# Installing

-   In the terminal type `flutter pub get` to install all required packages

# Developing

1. Install with

    ```sh
    git clone https://github.com/LeafGlobalFintech/loan_app
    cd loan_app
    flutter run --dart-define CREDO_AUTH_KEY=CREDO_AUTH_KEY --dart-define CREDO_URL=CREDO_URL
    ```
2. Checkout a branch from `develop` and make your changes in it branch (say, `feat-new-stuff`). These changes can be adding new features, fixing bugs, adding documentations, or refactoring existing code. Make sure your commit messages reflect your changes. Look at the section below for detailed instructions.

3. Make sure that your branch successfully compiles and finishes `flutter analyze` without any error or warning. We won't be able to merge your PR if your code doesn't pass.

4. Make sure to periodically merge `develop` into your branch to avoid conflicts when creating a PR.

# Commit Message Structure

-   If you are committing a feature, add `feat:` prefix then add description of the message.

```
Example: feat: added readme file
```

-   If you are committing a fix, add `fix:` prefix then add description of the message

```
Example: fix: fixed typo in readme file
```

-   If you are committing an improvement of an existing code, add `impr:` prefix then add description of the message

```
Example: impr: added validating to if an id is a mongodb id on top of checking if the field is empty
```

-   If you are committing a refactor of an existing code, add `refact:` prefix then add description of the message

```
Example: refact: reduced code for checking for null values on array
```

-   **Tip**: You can combine commit prefixes like:

```
Example: feat&fix: added readme file, fixed typo in readme file
```


