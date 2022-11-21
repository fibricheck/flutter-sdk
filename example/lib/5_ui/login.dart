import 'package:flutter/material.dart';
import 'package:flutter_fibricheck_sdk/flutter_fibricheck_sdk.dart';
import 'package:flutter_fibricheck_sdk/authentication_data.dart';
import 'package:flutter_fibricheck_sdk_example/5_ui/register.dart';
import 'package:flutter_fibricheck_sdk_example/5_ui/widgets/fc_primarybutton.dart';
import 'package:flutter_fibricheck_sdk_example/5_ui/widgets/fc_textfield.dart';

import '../0_design_system/fc_colors.dart';
import 'dashboard.dart';

class Login extends StatelessWidget {
  Login({super.key, required this.sdk});

  final FLFibriCheckSdk sdk;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FCColors.brokenWhite,
      appBar: AppBar(
        backgroundColor: FCColors.green,
        title: const Text('Login'),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: .5, color: FCColors.lightGray),
                left: BorderSide(width: .5, color: FCColors.lightGray),
                right: BorderSide(width: .5, color: FCColors.lightGray),
                bottom: BorderSide(width: .5, color: FCColors.lightGray),
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: FCTextFieldWidget(
                    editingController: emailController,
                    label: "Email",
                    obscureText: false,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: FCTextFieldWidget(
                    editingController: passwordController,
                    label: "Password",
                    obscureText: true,
                  ),
                ),
                FCPrimaryButtonWidget(
                    onPressed: () async => {
                          await _onLogin(context),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashBoard(
                                        sdk: sdk,
                                      )))
                        },
                    label: "Log in"),
                TextButton(
                  child: const Text(
                    "Register",
                    style: TextStyle(color: FCColors.green),
                  ),
                  onPressed: () => _onRegister(context),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future _onLogin(BuildContext context) async {
    await sdk.authenticateWithEmail(
      ParamsOauth1WithEmail(email: emailController.text, password: passwordController.text),
      (consents) {
        _onConsentNeeded(consents);
      },
    );
  }

  void _onRegister(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Register(
                  sdk: sdk,
                )));
  }

  void _onConsentNeeded(List<Consent> documentsToSign) {
    for (var document in documentsToSign) {
      {
        // 1. Request approval from the user

        // 2. Pass the document back to the sdk
        sdk.giveConsent(document);
      }
    }
  }
}
