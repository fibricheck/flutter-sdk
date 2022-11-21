import 'package:flutter/material.dart';
import 'package:flutter_fibricheck_sdk/flutter_fibricheck_sdk.dart';

import '5_ui/login.dart';

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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _sdk = FLFibriCheckSdk.client(
        "8076881385e4ef4c87b5ddb618de27c2938d128f", "08c969ea92caf22ca82df7ec065bbe4c9202f9a8",
        env: Env.dev);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(
        sdk: _sdk,
      ),
    );
  }
}
