import 'package:flutter_fibricheck_sdk/api/httpclient.dart';
import 'package:flutter_fibricheck_sdk/flutter_fibricheck_sdk.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_fibricheck_sdk/sdk_errors.dart';
import 'measurement_test.mocks.dart';
import 'test_data.dart';

@GenerateMocks([OAuth1Client])
void main() {
  group('measurements', () {
    var mockClient = MockOAuth1Client();
    PackageInfo.setMockInitialValues(
        appName: "appName",
        packageName: "packageName",
        version: "version",
        buildNumber: "1",
        buildSignature: "buildSignature");
    var sdk = FLFibriCheckSdk(mockClient);
    sdk.suppressPlatformCheckError = true;
    when(mockClient.consumerKey).thenReturn("key");
    when(mockClient.consumerSecret).thenReturn("secret");
    TestWidgetsFlutterBinding.ensureInitialized();

    test("should post a measurement", () async {
      when(mockClient.postMeasurement(any)).thenAnswer((_) async => Response(newUserData, 200));
      when(mockClient.getDocuments()).thenAnswer((_) async => Response(canPerformMeasurement, 200));

      await sdk.postMeasurement(measurementCreationData, "cameraSdkVersion");
      verify(mockClient.postMeasurement(any)).called(1);
    });

    test("should not post a measurement", () async {
      when(mockClient.postMeasurement(any)).thenAnswer((_) async => Response(newUserData, 200));
      when(mockClient.getDocuments()).thenAnswer((_) async => Response(cantPerformMeasurement, 200));

      expect(() async => await sdk.postMeasurement(measurementCreationData, "cameraSdkVersion"),
          throwsA(const TypeMatcher<NoActivePrescriptionError>()));
    });

    test("should fetch a measurement", () async {
      when(mockClient.getMeasurement(any)).thenAnswer((_) async => Response('{ "data": [{}]}', 200));

      await sdk.getMeasurement("measurementId");

      verify(mockClient.getMeasurement(any)).called(1);
    });

    test("should fetch measurements", () async {
      when(mockClient.getMeasurements(any))
          .thenAnswer((_) async => Response('{ "page": { "limit":0, "offset":0, "total":0 }, "data": [{}]}', 200));

      await sdk.getMeasurements(true);

      verify(mockClient.getMeasurements(any)).called(1);
    });
  });
}
