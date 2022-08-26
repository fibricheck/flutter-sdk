import 'package:flutter/material.dart';
import 'package:flutter_fibricheck_sdk/flutter_fibricheck_sdk.dart';
import 'package:flutter_fibricheck_sdk/userdata.dart';
import 'package:flutter_fibricheck_sdk_example/5_ui/widgets/fc_primarybutton.dart';
import 'package:flutter_fibricheck_sdk_example/5_ui/widgets/fc_textfield.dart';

import '../0_design_system/fc_colors.dart';
import 'dashboard.dart';

class Register extends StatelessWidget {
  Register({super.key, required this.sdk});

  final FLFibriCheckSdk sdk;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final languageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FCColors.brokenWhite,
      appBar: AppBar(
        backgroundColor: FCColors.green,
        title: const Text('Register'),
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
                    editingController: firstNameController,
                    label: "First name",
                    obscureText: false,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: FCTextFieldWidget(
                    editingController: lastNameController,
                    label: "Last name",
                    obscureText: false,
                  ),
                ),
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
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: FCTextFieldWidget(
                    editingController: phoneNumberController,
                    label: "Phone number",
                    obscureText: false,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: FCTextFieldWidget(
                    editingController: languageController,
                    label: "Language code",
                    obscureText: false,
                  ),
                ),
                FCPrimaryButtonWidget(
                    onPressed: () async => {
                          await _onRegister(context),
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashBoard(
                                        sdk: sdk,
                                      )))
                        },
                    label: "Register"),
                TextButton(
                  child: const Text(
                    "Login",
                    style: TextStyle(color: FCColors.green),
                  ),
                  onPressed: () => _onLogin(context),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onLogin(BuildContext context) async {
    Navigator.pop(context);
  }

  Future _onRegister(BuildContext context) async {
    var userData = UserRegisterData(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      password: passwordController.text,
      phoneNumber: phoneNumberController.text,
      language: languageController.text,
    );

    await sdk.register(userData);

    await sdk.authenticateWithEmail(
      ParamsOauth1WithEmail(email: emailController.text, password: passwordController.text),
      (consents) {
        _onConsentNeeded(consents);
      },
    );
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
