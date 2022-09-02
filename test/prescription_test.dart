import 'package:flutter_fibricheck_sdk/api/httpclient.dart';
import 'package:flutter_fibricheck_sdk/flutter_fibricheck_sdk.dart';
import 'package:flutter_fibricheck_sdk/sdk_errors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'prescription_test.mocks.dart';
import 'test_data.dart';

@GenerateMocks([OAuth1Client])
void main() {
  group('prescription', () {
    var mockClient = MockOAuth1Client();
    var sdk = FLFibriCheckSdk(mockClient);
    when(mockClient.consumerKey).thenReturn("key");
    when(mockClient.consumerSecret).thenReturn("secret");
    when(mockClient.activatePrescription(any)).thenAnswer((_) async => Response("", 200));
    when(mockClient.linkPrescription(any)).thenAnswer((_) async => Response("", 200));

    test("activates an linked prescription successfully", () async {
      when(mockClient.getPrescription(any)).thenAnswer((_) async => Response(linkedPrescription, 200));

      await sdk.activatePrescription("hash");
      verify(mockClient.activatePrescription(any)).called(1);
    });

    test("activates an unlinked prescription successfully", () async {
      when(mockClient.getPrescription(any)).thenAnswer((_) async => Response(unlinkedPrescription, 200));

      await sdk.activatePrescription("hash");
      verify(mockClient.activatePrescription(any)).called(1);
      verify(mockClient.linkPrescription(any)).called(1);
    });

    test("throws already activated prescription", () async {
      when(mockClient.getPrescription(any)).thenAnswer((_) async => Response(activatedPrescription, 200));

      expect(() async => await sdk.activatePrescription("hash"), throwsA(const TypeMatcher<AlreadyActivatedError>()));
    });

    test("throws with an unpaid prescription", () async {
      when(mockClient.getPrescription(any)).thenAnswer((_) async => Response(notPaidPrescription, 200));

      expect(() async => await sdk.activatePrescription("hash"), throwsA(const TypeMatcher<NotPaidError>()));
    });
  });
}
