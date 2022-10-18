import 'package:flutter/material.dart';
import 'package:flutter_fibricheck_sdk/flutter_fibricheck_sdk.dart';
import 'package:flutter_fibricheck_sdk/measurement.dart';
import 'package:flutter_fibricheck_sdk_example/5_ui/widgets/fc_primarybutton.dart';
import 'package:intl/intl.dart';

import '../0_design_system/fc_colors.dart';
import 'camera.dart';
import 'detail.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key, required this.sdk});
  final FLFibriCheckSdk sdk;

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final hashController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: FCColors.brokenWhite,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.logout_sharp),
            onPressed: () {
              widget.sdk.logout();
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                await postMeasurement(context);
              },
            ),
          ],
          backgroundColor: FCColors.green,
          title: const Text('Measurements'),
        ),
        body: FutureBuilder<List<Measurement>>(
          future: _getMeasurements(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting: return const Center(
                child: CircularProgressIndicator(
                  color: FCColors.green,
                ),
              );
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                List<Measurement> measurements = snapshot.data!;
                return ListView.separated(
                  itemCount: measurements.length,
                  itemBuilder: (context, index) {
                    var m = measurements[index];
                    DateTime date = m.creationTimestamp ?? DateTime.now();
                    var hearthRateText = "Hearthrate: ${m.data?.heartrate.toString() ?? "-"}";
                    return GestureDetector(
                        onTap: (() => {navigate(context, m)}),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat("yyyy-MM-dd").format(date),
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  _mapStatusToStatusText(m.status)
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(hearthRateText),
                                ],
                              )
                            ],
                          ),
                        ));
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                );
            }
          },
        ));
  }

  Future<List<Measurement>> _getMeasurements() async {
    var res = await widget.sdk.getMeasurements(true);
    return res.result;
  }

  Future<void> postMeasurement(BuildContext context) async {
    var canPostMeasurement = await widget.sdk.canPerformMeasurement();
    if (canPostMeasurement) {
      // ignore: use_build_context_synchronously
      var result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CameraScreen(
                    sdk: widget.sdk,
                  )));
      if (result) {
        await _getMeasurements();
        setState(() {});
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Activate prescription'),
              content: TextField(
                controller: hashController,
              ),
              actions: <Widget>[
                FCPrimaryButtonWidget(
                    onPressed: () => _activatePrescription(hashController.text, context), label: "OK"),
                TextButton(
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: FCColors.green),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          });
    }
  }

  Future _activatePrescription(String hash, BuildContext context) async {
    await widget.sdk.activatePrescription(hash);
    // ignore: use_build_context_synchronously
    await postMeasurement(context);
  }

  void navigate(BuildContext context, Measurement measurement) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Detail(
                  sdk: widget.sdk,
                  measurement: measurement,
                ))).whenComplete(() => {setState(() {})});
  }

  Text _mapStatusToStatusText(MeasurementStatus? status) {
    var label = "";
    Color color = Colors.blue;
    switch (status) {
      case MeasurementStatus.measured:
        label = "Measured";
        break;
      case MeasurementStatus.preprocessingSelection:
      case MeasurementStatus.analysisSelection:
      case MeasurementStatus.pendingAnalysis:
        label = "Analysis being prepared";
        break;
      case MeasurementStatus.underAnalysis:
        label = "Under analysis";
        break;
      case MeasurementStatus.analysisFailed:
        label = "Analysis failed";
        color = Colors.red;
        break;
      case MeasurementStatus.processingResults:
        label = "Analyse being processed";
        break;
      case MeasurementStatus.analyzed:
        label = "Analysis finished";
        color = FCColors.green;
        break;
      case MeasurementStatus.pendingReview:
        label = "Review being prepared";
        break;
      case MeasurementStatus.reviewed:
        label = "Review finished";
        color = FCColors.green;
        break;
      default:
        break;
    }
    return Text(
      label,
      style: TextStyle(color: color, fontWeight: FontWeight.bold),
    );
  }
}
