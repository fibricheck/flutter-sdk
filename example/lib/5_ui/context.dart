import 'package:flutter/material.dart';
import 'package:flutter_fibricheck_sdk/flutter_fibricheck_sdk.dart';
import 'package:flutter_fibricheck_sdk/measurement.dart';
import 'package:flutter_fibricheck_sdk_example/5_ui/widgets/fc_primarybutton.dart';

import '../0_design_system/fc_colors.dart';

class Context extends StatefulWidget {
  const Context({super.key, required this.sdk, required this.measurement});

  final FLFibriCheckSdk sdk;
  final Measurement measurement;

  @override
  State<Context> createState() => _ContextState();
}

class _ContextState extends State<Context> {
  late String reportUrl;

  Activity? activityDropdownValue;
  SymptomSeverity? severityDropdownValue;
  Map<Symptoms, bool> symptoms = <Symptoms, bool>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: FCColors.brokenWhite,
        appBar: AppBar(
          backgroundColor: FCColors.green,
          title: const Text('Context'),
        ),
        body: Builder(builder: (context) {
          if (symptoms.isEmpty) {
            for (var s in Symptoms.values) {
              symptoms[s] = widget.measurement.data?.context?.symptoms?.any((element) => element == s) ?? false;
            }
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Measurement context",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.all(2)),
              DropdownButton<Activity>(
                value: activityDropdownValue ?? widget.measurement.data?.context?.activity,
                onChanged: (Activity? newValue) {
                  setState(() {
                    activityDropdownValue = newValue!;
                  });
                },
                items: Activity.values.map<DropdownMenuItem<Activity>>((Activity value) {
                  return DropdownMenuItem<Activity>(
                    value: value,
                    child: Text(_mapActivityToActivityText(value)),
                  );
                }).toList(),
              ),
              const Padding(padding: EdgeInsets.all(2)),
              Column(
                children: [
                  for (var s in symptoms.entries)
                    CheckboxListTile(
                      title: Text(_getSymptomsText(s.key)),
                      value: s.value,
                      onChanged: (e) => {
                        setState(() {
                          symptoms.update(s.key, (value) => e!);
                        })
                      },
                    )
                ],
              ),
              const Padding(padding: EdgeInsets.all(2)),
              const Text("Symptom severity"),
              DropdownButton<SymptomSeverity>(
                value: severityDropdownValue ?? widget.measurement.data?.context?.symptomSeverity,
                onChanged: (SymptomSeverity? newValue) {
                  setState(() {
                    severityDropdownValue = newValue!;
                  });
                },
                items: SymptomSeverity.values.map<DropdownMenuItem<SymptomSeverity>>((SymptomSeverity value) {
                  return DropdownMenuItem<SymptomSeverity>(
                    value: value,
                    child: Text(_getSymptomSeverityText(value)),
                  );
                }).toList(),
              ),
              const Divider(),
              FCPrimaryButtonWidget(
                  onPressed: () async => {
                        await _onSave(),
                        Navigator.pop(context),
                      },
                  label: "Save changes"),
            ],
          );
        }));
  }

  Future _onSave() async {
    List<Symptoms> symptomList = [];
    for (var s in symptoms.entries) {
      if (s.value) symptomList.add(s.key);
    }
    var context = MeasurementContext(
        symptoms: symptomList, activity: activityDropdownValue, symptomSeverity: severityDropdownValue);
    await widget.sdk.updateMeasurementContext(widget.measurement.id!, context);
  }

  String _mapActivityToActivityText(Activity? activity) {
    var label = "";
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
    return label;
  }

  String _getSymptomsText(Symptoms symptoms) {
    var label = "";

    switch (symptoms) {
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
      case Symptoms.racingHeart:
        label += "racing heart";
        break;
      case Symptoms.dizziness:
        label += "dizziness";
        break;
      case Symptoms.feelingOfFainting:
        label += "feeling of fainting";
        break;
    }
    return label;
  }

  String _getSymptomSeverityText(SymptomSeverity? symptomSeverity) {
    var label = "";
    switch (symptomSeverity) {
      case SymptomSeverity.severity_2a:
        label = "mild";
        break;
      case SymptomSeverity.severity_2b:
        label = "moderate";
        break;
      case SymptomSeverity.severity_3:
        label = "severe";
        break;
      case SymptomSeverity.severity_4:
        label = "disabling";
        break;
      default:
        label = "none";
        break;
    }
    return label;
  }
}
