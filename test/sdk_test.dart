import 'package:flutter_fibricheck_sdk/api/httpclient.dart';
import 'package:flutter_fibricheck_sdk/flutter_fibricheck_sdk.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'sdk_test.mocks.dart';

@GenerateMocks([OAuth1Client])
void main() {
  group('sdk', () {
    test("should create a http client", () async {
      var mockClient = MockOAuth1Client();
      var sdk = FLFibriCheckSdk(mockClient);
      expect(sdk, isNotNull);
    });
  });
}
