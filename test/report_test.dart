import 'package:flutter_fibricheck_sdk/src/api/httpclient.dart';
import 'package:flutter_fibricheck_sdk/src/flutter_fibricheck_sdk.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'report_test.mocks.dart';

@GenerateMocks([OAuth1Client])
void main() {
  var mockClient = MockOAuth1Client();
  var sdk = FLFibriCheckSdk(mockClient);
  when(mockClient.consumerKey).thenReturn("key");
  when(mockClient.consumerSecret).thenReturn("secret");

  group('report', () {
    test("should get a report url for existing report", () async {
      when(mockClient.getMeasurementReportUrl(any)).thenAnswer(
          (_) async => Response('{"data": [ { "status": "rendered", "data": {"readFileToken": "token" } } ] }', 200));
      when(mockClient.host).thenReturn("host");

      var res = await sdk.getMeasurementReportUrl("measurementId");
      expect(res, "host/files/v1/token/file");
    });

    test("should create a report", () async {
      when(mockClient.getMeasurementReportUrl(any))
          .thenAnswer((_) async => Response('{"data": [ { "data": {} } ] }', 200));
      when(mockClient.createMeasurementReportUrl(any))
          .thenAnswer((_) async => Response('{"data": [ { "data": {"readFileToken": "token" } } ] }', 200));
      when(mockClient.host).thenReturn("host");

      var res = await sdk.getMeasurementReportUrl("measurementId");
      expect(res, "host/files/v1/token/file");
    });
  });
}
