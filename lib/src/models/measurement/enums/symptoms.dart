// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

enum Symptoms {
  @JsonValue('no_symptoms')
  noSymptoms,
  lightheaded,
  confused,
  fatigue,
  other,
  palpitations,
  @JsonValue('chest_pains')
  chestPains,
  @JsonValue('shortness_of_breath')
  shortnessOfBreath,
  @JsonValue('racing_heart')
  racingHeart,
  dizziness,
  @JsonValue('feeling_of_fainting')
  feelingOfFainting,
}
