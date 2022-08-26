import 'package:flutter/material.dart';
import 'package:flutter_fibricheck_sdk/flutter_fibricheck_sdk.dart';
import 'package:flutter_fibricheck_sdk/measurement.dart';
import 'package:flutter_fibricheck_sdk_example/5_ui/widgets/fc_primarybutton.dart';
import 'package:url_launcher/url_launcher.dart';

import '../0_design_system/fc_colors.dart';
import 'context.dart';

// ignore: must_be_immutable
class Detail extends StatefulWidget {
  Detail({super.key, required this.sdk, required this.measurement});

  final FLFibriCheckSdk sdk;
  Measurement measurement;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  late String reportUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: FCColors.brokenWhite,
        appBar: AppBar(
          backgroundColor: FCColors.green,
          title: const Text('Measurement'),
        ),
        body: FutureBuilder(
            future: _getReportUrl(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: FCColors.green,
                  ),
                );
              } else {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _mapStatusToStatusText(widget.measurement.status),
                    Text("Hearthrate: ${widget.measurement.data?.heartrate.toString() ?? "-"}"),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Measurement context",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextButton(onPressed: (() => {_editContext(context)}), child: const Text("Edit"))
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(2)),
                    _mapActivityToActivityText(widget.measurement.data?.context?.activity),
                    const Padding(padding: EdgeInsets.all(2)),
                    _getSymptomsText(widget.measurement.data?.context?.symptoms),
                    const Padding(padding: EdgeInsets.all(2)),
                    _getSymptomSeverityText(widget.measurement.data?.context?.symptomSeverity),
                    const Divider(),
                    FCPrimaryButtonWidget(onPressed: _launchUrl, label: "View report"),
                    const Text(
                      "report may not render on simulators",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                    ),
                  ],
                );
              }
            }));
  }

  Future _getReportUrl() async {
    var res = await widget.sdk.getMeasurementReportUrl(widget.measurement.id!);
    reportUrl = res;
  }

  Future<void> _launchUrl() async {
    if (await canLaunchUrl(Uri.parse(reportUrl))) {
      if (!await launchUrl(Uri.parse(reportUrl))) {
        throw 'Could not launch $reportUrl';
      }
    }
  }

  Future _editContext(BuildContext context) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Context(
                  sdk: widget.sdk,
                  measurement: widget.measurement,
                )));

    var res = await widget.sdk.getMeasurement(widget.measurement.id!);
    setState(() {
      widget.measurement = res;
    });
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

  Text _mapActivityToActivityText(Activity? activity) {
    var label = "Activity: ";
    switch (activity) {
      case Activity.resting:
        label += "resting";
        break;
      case Activity.sleeping:
        label += "sleeping";
        break;
      case Activity.sitting:
        label += "sitting";
        break;
      case Activity.walking:
        label += "walking";
        break;
      case Activity.working:
        label += "working";
        break;
      case Activity.exercising:
        label += "exercising";
        break;
      case Activity.other:
        label += "other";
        break;
      case Activity.standing:
        label += "standing";
        break;
      default:
        label += "unknown";
        break;
    }
    return Text(
      label,
    );
  }

  Text _getSymptomsText(List<Symptoms>? symptoms) {
    var label = "Symptoms: ";
    if (symptoms == null || symptoms.isEmpty) return Text("${label}unknown");

    var isFirst = true;
    for (var s in symptoms) {
      if (!isFirst) label += ", ";
      isFirst = false;

      switch (s) {
        case Symptoms.noSymptoms:
          label += "no symptoms";
          break;
        case Symptoms.lightheaded:
          label += "lightheaded";
          break;
        case Symptoms.confused:
          label += "confused";
          break;
        case Symptoms.fatigue:
          label += "fatigue";
          break;
        case Symptoms.other:
          label += "other";
          break;
        case Symptoms.palpitations:
          label += "palpitations";
          break;
        case Symptoms.chestPains:
          label += "chest pains";
          break;
        case Symptoms.shortnessOfBreath:
          label += "shortness of breath";
          break;
      }
    }
    return Text(label);
  }

  Text _getSymptomSeverityText(SymptomSeverity? symptomSeverity) {
    var label = "Symptom severity: ";
    switch (symptomSeverity) {
      case SymptomSeverity.severity_2a:
        label += "mild";
        break;
      case SymptomSeverity.severity_2b:
        label += "moderate";
        break;
      case SymptomSeverity.severity_3:
        label += "severe";
        break;
      case SymptomSeverity.severity_4:
        label += "disabling";
        break;
      default:
        label += "none";
        break;
    }
    return Text(label);
  }
}
