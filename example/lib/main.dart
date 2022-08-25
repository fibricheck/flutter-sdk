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
        "4fb27224d586ff38c06ad6e622725e5590d7951a", "f1c54ff53a86e2b79e11a345c999d2d77d91f72f",
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
