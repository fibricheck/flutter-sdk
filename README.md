# Getting Started

This package serves as a Flutter wrapper around all [FibriCheck](https://www.fibricheck.com) cloud services.

To get started with the FibriCheck SDK you'll need to install it, and then get credentials which will allow you to access the backend.

## Installation

In your project you can add the package below to the pubspec.yaml file. Replace {TOKEN} with your personal access token. You can get a new one at [here](https://github.com/settings/tokens/new). You'll need access to the private repository in order to use the package.

```
   flutter_fibricheck_sdk:
     git:
       url: https://{TOKEN}@github.com/fibricheck/flutter-sdk
       ref: v0.0.1
```

## Documentation

You can find the latest documentation and examples on [https://docs.fibricheck.com](https://docs.fibricheck.com/).

## Quick Start

```dart
import 'package:flutter_fibricheck_sdk/flutter_fibricheck_sdk.dart';

_sdk = FLFibriCheckSdk.client("consumerKey", "consumerSecret");

await _sdk.authenticateWithEmail(
      ParamsOauth1WithEmail(email: "email", password: "password"),
      (consents) {
        _onConsentNeeded(consents);
      },
    );
```

## Example App Instructions

- uncomment the camera_sdk in 'pubspec.yaml' and add a valid GitHub token
- uncomment the commented lines in camera.dart