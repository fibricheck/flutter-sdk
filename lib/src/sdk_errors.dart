import 'dart:convert';

import 'package:http/http.dart';

class SdkError {
  final String? errorBody;

  SdkError({this.errorBody});
}

class EmailUsedError extends SdkError {
  EmailUsedError({required super.errorBody});
}

class ApplicationNotAuthenticatedError extends SdkError {
  ApplicationNotAuthenticatedError({required super.errorBody});
}

class AuthenticationError extends SdkError {
  AuthenticationError({required super.errorBody});
}

class LoginTimeoutError extends SdkError {
  LoginTimeoutError({required super.errorBody});
}

class LoginFreezeError extends SdkError {
  LoginFreezeError({required super.errorBody});
}

class TooManyFailedAttemptsError extends SdkError {
  TooManyFailedAttemptsError({required super.errorBody});
}

class MfaRequiredError extends SdkError {
  MfaRequiredError({required super.errorBody});
}

class NoActivePrescriptionError extends SdkError {
  NoActivePrescriptionError();
}

class LockedDocumentError extends SdkError {
  LockedDocumentError({required super.errorBody});
}

class AlreadyActivatedError extends SdkError {
  AlreadyActivatedError();
}

class NotPaidError extends SdkError {
  NotPaidError();
}

class MeasurementReportRenderingTimeout extends SdkError {
  MeasurementReportRenderingTimeout();
}


extension ErrorsFromResponseExtension on Response {
  void throwSDKErrorIfNeeded() {
    if (statusCode == 200) {
      return;
    }

    final exhCode = jsonDecode(body)["code"];

    switch (exhCode) {
      case 101:
        throw ApplicationNotAuthenticatedError(errorBody: body);
      case 106:
        throw AuthenticationError(errorBody: body);
      case 129:
        throw MfaRequiredError(errorBody: body);
      case 203:
        throw EmailUsedError(errorBody: body);
      case 211:
        throw LoginTimeoutError(errorBody: body);
      case 212:
        throw LoginFreezeError(errorBody: body);
      case 213:
        throw TooManyFailedAttemptsError(errorBody: body);
      case 415:
        throw LockedDocumentError(errorBody: body);
    }  }
// ···
}