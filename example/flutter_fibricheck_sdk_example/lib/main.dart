import 'package:flutter/material.dart';
import 'package:flutter_fibricheck_sdk/flutter_fibricheck_sdk.dart';
import 'package:flutter_fibricheck_sdk/measurement.dart';
import 'package:flutter_fibricheck_sdk/profiledata.dart';
import 'package:flutter_fibricheck_sdk/sdk_errors.dart';
import 'package:flutter_fibricheck_sdk/userdata.dart';

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
    _sdk = FLFibriCheckSdk.client(
        "4fb27224d586ff38c06ad6e622725e5590d7951a", "f1c54ff53a86e2b79e11a345c999d2d77d91f72f",
        env: Env.dev);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Testing shortcuts'),
      ),
      body: ListView(
        children: [
          TextButton(
            onPressed: register,
            child: const Text('register'),
          ),
          TextButton(
            onPressed: authenticateWithToken,
            child: const Text('auth token'),
          ),
          TextButton(
            onPressed: authenticateWithEmail,
            child: const Text('auth email'),
          ),
          TextButton(
            onPressed: logout,
            child: const Text('logout'),
          ),
          TextButton(
            onPressed: postMeasurement,
            child: const Text('post measurement'),
          ),
          TextButton(
            onPressed: canPerformMeasurement,
            child: const Text('canPerformMeasurement'),
          ),
          TextButton(
            onPressed: updateMeasurementContext,
            child: const Text('update measurement context'),
          ),
          TextButton(
            onPressed: updateProfile,
            child: const Text('update profile'),
          ),
          TextButton(
            onPressed: getMeasurement,
            child: const Text('get measurement'),
          ),
          TextButton(
            onPressed: getMeasurements,
            child: const Text('get measurements'),
          ),
          TextButton(
            onPressed: getMeasurementReportUrl,
            child: const Text('get measurement report url'),
          ),
          TextButton(
            onPressed: getPeriodicReports,
            child: const Text('get periodic reports'),
          ),
          TextButton(
            onPressed: activatePrescription,
            child: const Text('active prescription'),
          ),
          TextButton(
            onPressed: getPeriodicReportPdf,
            child: const Text('get periodic report pdf'),
          ),
        ],
      ),
    ));
  }

  Future<void> register() async {
    try {
      await _sdk.register(UserRegisterData(
        firstName: "",
        lastName: "",
        email: "",
        password: "",
        phoneNumber: "",
        language: "",
      ));
    } on EmailUsedError {
      // -> show error to user
    }
  }

  Future<void> authenticateWithEmail() async {
    await _sdk.authenticateWithEmail(
        ParamsOauth1WithEmail(
          email: "",
          password: "",
        ),
        onConsentNeeded);
  }

  Future<void> authenticateWithToken() async {
    await _sdk.authenticateWithToken(
        ParamsOauth1WithToken(
          token: "",
          tokenSecret: "",
        ),
        onConsentNeeded);
  }

  /// from https://docs.fibricheck.com/examples#check-for-updated-legal-documents
  void onConsentNeeded(List<Consent> documentsToSign) {
    for (var document in documentsToSign) {
      {
        // 1. Request approval from the user

        // 2. Pass the document back to the sdk
        _sdk.giveConsent(document);
      }
    }
  }

  Future<void> postMeasurement() async {
    await _sdk.postMeasurement(
        MeasurementCreationData(
          heartrate: 85,
          measurementTimestamp: DateTime.now().millisecondsSinceEpoch,
          quadrants: <List<Yuv>>[
            <Yuv>[
              Yuv(
                y: [1, 2, 3],
                u: [1, 2, 3],
                v: [1, 2, 3],
              ),
            ],
            <Yuv>[
              Yuv(
                y: [1, 2, 3],
                u: [1, 2, 3],
                v: [1, 2, 3],
              ),
            ],
          ],
          technicalDetails: TechnicalDetails(
            cameraExposureTime: 19990000,
            cameraHardwareLevel: "camera2 - full",
            cameraIso: 250,
          ),
          time: <num>[1, 2, 3],
          yList: <num>[1, 2, 3],
        ),
        "1.0.0");
  }

  Future<void> canPerformMeasurement() async {
    await _sdk.canPerformMeasurement();
  }

  Future<void> updateMeasurementContext() async {
    await _sdk.updateMeasurementContext(
      "",
      MeasurementContext(
        symptoms: <Symptoms>[Symptoms.fatigue, Symptoms.lightheaded],
        activity: Activity.sitting,
        symptomSeverity: SymptomSeverity.severity_2b,
      ),
    );
  }

  Future<void> getMeasurements() async {
    var res = await _sdk.getMeasurements(true);
    await res.getNextMeasurements();
    await res.getPreviousMeasurements();
  }

  Future<void> getMeasurement() async {
    await _sdk.getMeasurement("");
  }

  Future<void> getMeasurementReportUrl() async {
    await _sdk.getMeasurementReportUrl("");
  }

  Future<void> activatePrescription() async {
    await _sdk.activatePrescription('');
  }

  void logout() {
    _sdk.logout();
  }

  Future<void> updateProfile() async {
    await _sdk.updateProfile(
        "",
        ProfileData(
            addressLine1: "test lijn 1",
            addressLine2: "test lijn 2",
            weight: 65,
            length: 170,
            smoker: false,
            activity: ProfileActivity.moderatelyActive,
            fibricheckInfo: FibricheckInfo(
              app: App(version: "1.0.0"),
              device: Device(
                manufacturer: "Apple",
                type: DeviceType.ios,
                model: "iPhone 13 Pro",
                os: "15.5",
              ),
            )));
  }

  Future<void> getPeriodicReportPdf() async {
    await _sdk.getPeriodicReportPdf("");
  }

  Future<void> getPeriodicReports() async {
    var res = await _sdk.getPeriodicReports(true);
    await res.getNextPagedPeriodicReportsResult();
    await res.getPreviousPagedPeriodicReportsResult();
  }
}
