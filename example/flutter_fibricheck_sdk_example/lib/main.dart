import 'package:flutter/material.dart';
import 'package:flutter_fibricheck_sdk/flutter_fibricheck_sdk.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FLFibriCheckSdk _sdk;

  @override
  void initState() {
    super.initState();
    _sdk = FLFibriCheckSdk.client("4fb27224d586ff38c06ad6e622725e5590d7951a",
        "f1c54ff53a86e2b79e11a345c999d2d77d91f72f",
        env: Env.dev);
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Fibricheck example app'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: register,
            child: Text('register'),
          ),
          TextButton(
            onPressed: authenticateWithEmail,
            child: Text('auth email'),
          ),
          TextButton(
            onPressed: canPerformMeasurement,
            child: Text('canPerformMeasurement'),
          ),
        ],
      ),
    ));
  }

  Future<void> register() async {
    var res = await _sdk.register(UserRegisterData(
      firstName: "Thomas",
      lastName: "Corbeel",
      email: "thomas.corbeel@flowpilots.com",
      password: "FlowPilots1",
      phoneNumber: "493507856",
      language: "NL",
    ));
  }

  Future<void> authenticateWithEmail() async {
    var res = await _sdk.authenticate(
        ParamsOauth1WithEmail(
          email: "thomas.corbeel@flowpilots.com",
          password: "FlowPilots1",
        ),
        onConsentNeeded);
  }

  /// from https://docs.fibricheck.com/examples#check-for-updated-legal-documents
  void onConsentNeeded(List<Consent> documentsToSign) {
    documentsToSign.forEach((document) => {
          // 1. Request approval from the user

          // 2. Pass the document back to the sdk
          _sdk.giveConsent(document)
        });
  }

  Future<void> canPerformMeasurement() async {
    var res = await _sdk.canPerformMeasurement();
  }

  void logout() {
    _sdk.logout();
  }
}
