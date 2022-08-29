// ignore_for_file: prefer_final_fields, unused_import, unused_field, unused_element

import 'dart:convert';

// import 'package:camera_sdk/fibri_check_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fibricheck_sdk/flutter_fibricheck_sdk.dart';
import 'package:flutter_fibricheck_sdk/measurement.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wakelock/wakelock.dart';

import '../0_design_system/fc_colors.dart';
import 'widgets/fc_metrics.dart';
import 'widgets/fc_title.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key, required this.sdk});

  final FLFibriCheckSdk sdk;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  Future<void>? _requestCameraPermission;

  bool _hasCameraPermission = false;
  bool _measurementFinished = false;

  String _timeRemaining = "-";
  String _heartBeat = "-";
  String _status = "Place your finger on the camera";
  Measurement? _measurement;

  @override
  initState() {
    super.initState();
    _requestCameraPermission = _requestCameraPermissionImpl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FCColors.brokenWhite,
      appBar: AppBar(
        backgroundColor: FCColors.green,
        title: const Text('Camera'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: _requestCameraPermission,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const DemoTitleWidget(title: "Requiring camera permission");
                }

                if (!_hasCameraPermission) {
                  return const DemoTitleWidget(title: "Camera permission not granted");
                }
                return Column(
                  children: [
                    DemoTitleWidget(title: _status),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: FCColors.lightGray, width: 1),
                          bottom: BorderSide(color: FCColors.lightGray, width: 1),
                        ),
                      ),
                      height: 200,
                      // child: FibriCheckView(
                      //   fibriCheckViewProperties: FibriCheckViewProperties(
                      //     flashEnabled: true,
                      //     lineThickness: 4,
                      //   ),
                      //   onCalibrationReady: () => {
                      //     debugPrint("Flutter onCalibrationReady"),
                      //     setState(() {
                      //       _status = "Recording heartbeat...";
                      //     }),
                      //   },
                      //   onFingerDetected: () => {
                      //     Wakelock.enable(),
                      //     debugPrint("Flutter onFingerDetected"),
                      //     setState(() {
                      //       _status = "Detecting pulse...";
                      //     }),
                      //   },
                      //   onFingerDetectionTimeExpired: () => debugPrint("Flutter onFingerDetectionTimeExpired"),
                      //   onFingerRemoved: () => {
                      //     Wakelock.disable(),
                      //     debugPrint("Flutter onFingerRemoved"),
                      //   },
                      //   onHeartBeat: (heartbeat) => {
                      //     debugPrint("Flutter onHeartBeat $heartbeat"),
                      //     setState(() {
                      //       _heartBeat = heartbeat.toString();
                      //     }),
                      //   },
                      //   onMeasurementFinished: () => {
                      //     debugPrint("Flutter onMeasurementFinished"),
                      //     setState(() {
                      //       _status = "Measurement finished!";
                      //     }),
                      //   },
                      //   onMeasurementProcessed: (measurement) async => {
                      //     await _onMeasurementFinished(measurement),
                      //     debugPrint("Flutter onMeasurementProcessed $measurement"),
                      //     if (Navigator.canPop(context)) Navigator.pop(context),
                      //   },
                      //   onPulseDetected: () => {
                      //     debugPrint("Flutter onPulseDetected"),
                      //     setState(() {
                      //       _status = "Calibrating...";
                      //     }),
                      //   },
                      //   onTimeRemaining: (seconds) => {
                      //     debugPrint("Flutter onTimeRemaining $seconds"),
                      //     setState(() {
                      //       _timeRemaining = seconds.toString();
                      //     }),
                      //   },
                      // ),
                    ),
                    DemoMetricsWidget(timeRemaining: _timeRemaining, heartBeat: _heartBeat),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _requestCameraPermissionImpl() async {
    var result = await Permission.camera.request();
    setState(() {
      _hasCameraPermission = result.isGranted;
    });
  }

  Future _onMeasurementFinished(String measurementString) async {
    var json = jsonDecode(measurementString);
    var mCreationData = MeasurementCreationData.fromJson(json);

    await widget.sdk.postMeasurement(mCreationData, "v0.0.1");
  }
}
