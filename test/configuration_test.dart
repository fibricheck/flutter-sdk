import 'package:flutter_fibricheck_sdk/api/httpclient.dart';
import 'package:flutter_fibricheck_sdk/flutter_fibricheck_sdk.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'measurement_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([OAuth1Client])
void main() {
  var mockClient = MockOAuth1Client(); 
  var sdk = FLFibriCheckSdk(mockClient);

  when(mockClient.consumerKey).thenReturn("key");
  when(mockClient.consumerSecret).thenReturn("secret");

  group("configuration", () {
    test("should get an json object for the general configuration", () async {
      when(mockClient.getGeneralConfiguration()).thenAnswer(
        (_) async => Response("", 200));
    });
  });
}
