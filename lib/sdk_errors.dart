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
