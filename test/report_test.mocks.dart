// Mocks generated by Mockito 5.3.2 from annotations
// in flutter_fibricheck_sdk/test/report_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:flutter_fibricheck_sdk/api/httpclient.dart' as _i3;
import 'package:flutter_fibricheck_sdk/authentication_data.dart' as _i6;
import 'package:flutter_fibricheck_sdk/paged_results.dart' as _i7;
import 'package:flutter_fibricheck_sdk/userdata.dart' as _i5;
import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeResponse_0 extends _i1.SmartFake implements _i2.Response {
  _FakeResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [OAuth1Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockOAuth1Client extends _i1.Mock implements _i3.OAuth1Client {
  MockOAuth1Client() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get host => (super.noSuchMethod(
        Invocation.getter(#host),
        returnValue: '',
      ) as String);
  @override
  String get consumerKey => (super.noSuchMethod(
        Invocation.getter(#consumerKey),
        returnValue: '',
      ) as String);
  @override
  String get consumerSecret => (super.noSuchMethod(
        Invocation.getter(#consumerSecret),
        returnValue: '',
      ) as String);
  @override
  set oAuthToken(String? _oAuthToken) => super.noSuchMethod(
        Invocation.setter(
          #oAuthToken,
          _oAuthToken,
        ),
        returnValueForMissingStub: null,
      );
  @override
  set oAuthTokenSecret(String? _oAuthTokenSecret) => super.noSuchMethod(
        Invocation.setter(
          #oAuthTokenSecret,
          _oAuthTokenSecret,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i4.Future<_i2.Response> register(_i5.UserRegisterData? body) =>
      (super.noSuchMethod(
        Invocation.method(
          #register,
          [body],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #register,
            [body],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> createOAuth1TokenWithEmail(
          _i6.ParamsOauth1WithEmail? body) =>
      (super.noSuchMethod(
        Invocation.method(
          #createOAuth1TokenWithEmail,
          [body],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #createOAuth1TokenWithEmail,
            [body],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> createOAuth1TokenWithToken(
          _i6.ParamsOauth1WithToken? body) =>
      (super.noSuchMethod(
        Invocation.method(
          #createOAuth1TokenWithToken,
          [body],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #createOAuth1TokenWithToken,
            [body],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> getMe(
    String? token,
    String? tokenSecret,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMe,
          [
            token,
            tokenSecret,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #getMe,
            [
              token,
              tokenSecret,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  bool logout() => (super.noSuchMethod(
        Invocation.method(
          #logout,
          [],
        ),
        returnValue: false,
      ) as bool);
  @override
  _i4.Future<_i2.Response> getGeneralConfiguration() => (super.noSuchMethod(
        Invocation.method(
          #getGeneralConfiguration,
          [],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #getGeneralConfiguration,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> getUserConfiguration(String? userId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserConfiguration,
          [userId],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #getUserConfiguration,
            [userId],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> updateUserConfig(
    String? userId,
    String? body,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateUserConfig,
          [
            userId,
            body,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #updateUserConfig,
            [
              userId,
              body,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> getPrescription(String? hash) => (super.noSuchMethod(
        Invocation.method(
          #getPrescription,
          [hash],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #getPrescription,
            [hash],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> getDocuments(String? userId) => (super.noSuchMethod(
        Invocation.method(
          #getDocuments,
          [userId],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #getDocuments,
            [userId],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> updateUserProfile(
    String? userId,
    String? updateData,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateUserProfile,
          [
            userId,
            updateData,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #updateUserProfile,
            [
              userId,
              updateData,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> getMeasurements(
    String? userId,
    bool? newestFirst,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMeasurements,
          [
            userId,
            newestFirst,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #getMeasurements,
            [
              userId,
              newestFirst,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> getNextMeasurements(
    String? userId,
    _i7.Page? page,
    bool? newestFirst,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getNextMeasurements,
          [
            userId,
            page,
            newestFirst,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #getNextMeasurements,
            [
              userId,
              page,
              newestFirst,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> getPreviousMeasurements(
    String? userId,
    _i7.Page? page,
    bool? newestFirst,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPreviousMeasurements,
          [
            userId,
            page,
            newestFirst,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #getPreviousMeasurements,
            [
              userId,
              page,
              newestFirst,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> getMeasurement(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getMeasurement,
          [id],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #getMeasurement,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> postMeasurement(String? body) => (super.noSuchMethod(
        Invocation.method(
          #postMeasurement,
          [body],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #postMeasurement,
            [body],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> updateMeasurementContext(
    String? measurementId,
    String? body,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateMeasurementContext,
          [
            measurementId,
            body,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #updateMeasurementContext,
            [
              measurementId,
              body,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> getPeriodicReportPdf(String? reportId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPeriodicReportPdf,
          [reportId],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #getPeriodicReportPdf,
            [reportId],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> getPeriodicReports(
    String? userId,
    bool? newestFirst,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPeriodicReports,
          [
            userId,
            newestFirst,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #getPeriodicReports,
            [
              userId,
              newestFirst,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> getNextPeriodicReports(
    String? userId,
    _i7.Page? page,
    bool? newestFirst,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getNextPeriodicReports,
          [
            userId,
            page,
            newestFirst,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #getNextPeriodicReports,
            [
              userId,
              page,
              newestFirst,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> getPreviousPeriodicReports(
    String? userId,
    _i7.Page? page,
    bool? newestFirst,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPreviousPeriodicReports,
          [
            userId,
            page,
            newestFirst,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #getPreviousPeriodicReports,
            [
              userId,
              page,
              newestFirst,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> getMeasurementReportUrl(String? measurementId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMeasurementReportUrl,
          [measurementId],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #getMeasurementReportUrl,
            [measurementId],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> createMeasurementReportUrl(String? measurementId) =>
      (super.noSuchMethod(
        Invocation.method(
          #createMeasurementReportUrl,
          [measurementId],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #createMeasurementReportUrl,
            [measurementId],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> activatePrescription(String? hash) =>
      (super.noSuchMethod(
        Invocation.method(
          #activatePrescription,
          [hash],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #activatePrescription,
            [hash],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> linkPrescription(String? hash) =>
      (super.noSuchMethod(
        Invocation.method(
          #linkPrescription,
          [hash],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #linkPrescription,
            [hash],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
}
