import 'package:flutter_fibricheck_sdk/measurement.dart';
import 'package:flutter_fibricheck_sdk/userdata.dart';

UserRegisterData userData = UserRegisterData(
    firstName: "John",
    lastName: "Doe",
    email: "john.doe@example.com",
    password: "string",
    phoneNumber: "7692837456",
    language: "NL",
    birthday: "1970/01/01",
    country: "NL",
    gender: Gender.female,
    region: "NL-GR");

const String newUserData =
    '{"id": "5bfbfc3146e0fb321rsa4b28","first_name": "John","last_name": "Doe","email": "john.doe@example.com","activation": true,"phone_number": "213243546","profile_image": "string","language": "NL","time_zone": "Europe/Brussels","last_failed_timestamp": 1543240753194,"failed_count": 0,"creation_timestamp": 1497265621409,"update_timestamp": 1565954044301}';

const String authWithEmailResult =
    '{"applicationId":"5811ccc246e0fb0006efdc8d","userId":"58074849b2148f3b28ad770c","token":"0c16c744bfec7192480799d96ddb1816649d8abb","tokenSecret":"f562292dad04c398c40ed6ec5dd674080c6b0618","updateTimestamp":"2022-09-01T18:39:59.663Z","creationTimestamp":"2022-09-01T18:39:59.663Z","id":"6310fc7f76487b6438e38316"}';

const String privacyDocumentV1 =
    '{"data": { "documents": { "privacy_policy": { "version": "1.0.0", "url": "https://pages.dev.fibricheck.com/privacy-policy/1.5.0/" } }}}';

const String privacyDocumentV2 =
    '{"data": { "documents": { "privacy_policy": { "version": "2.0.0", "url": "https://pages.dev.fibricheck.com/privacy-policy/1.5.0/" } }}}';

const String affected1Record = '{ "affectedRecords": 1 }';

MeasurementCreationData measurementCreationData = MeasurementCreationData(
  heartrate: 70,
  measurementTimestamp: DateTime.now().millisecondsSinceEpoch,
  quadrants: <List<Yuv>>[],
  technicalDetails: TechnicalDetails(
    cameraExposureTime: 0,
    cameraHardwareLevel: "cameraHardwareLevel",
    cameraIso: 0,
    cameraResolution: "cameraResolution",
  ),
  time: <num>[],
  yList: <num>[],
);

const String canPerformMeasurement = '{"data": [ { "data": { "canPerformMeasurement": true } } ] }';
const String cantPerformMeasurement = '{"data": [ { "data": { "canPerformMeasurement": false } } ] }';

const linkedPrescription = '{ "data": [ { "status": "FREE", "userId": "1" } ] }';
const unlinkedPrescription = '{ "data": [ { "status": "FREE" } ] }';
const activatedPrescription = '{ "data": [ { "status": "ACTIVATED" } ] }';
const notPaidPrescription = '{ "data": [ { "status": "NOT_PAID" } ] }';
