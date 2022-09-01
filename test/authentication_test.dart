import 'package:flutter_fibricheck_sdk/api/httpclient.dart';
import 'package:flutter_fibricheck_sdk/flutter_fibricheck_sdk.dart';
import 'package:flutter_fibricheck_sdk/userdata.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'authentication_test.mocks.dart';
import 'test_data.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([OAuth1Client])
void main() {
  group('authentication', () {
    var mockClient = MockOAuth1Client();
    var sdk = FLFibriCheckSdk(mockClient);
    when(mockClient.consumerKey).thenReturn("key");
    when(mockClient.consumerSecret).thenReturn("secret");
    test("should register a new user", () async {
      when(mockClient.register(userData)).thenAnswer((_) async => Response(newUserData, 200));

      await sdk.register(
        userData,
      );

      verify(mockClient.register(any)).called(1);
    });

    test("should authenticate a user", () async {
      var oautWithEmail = ParamsOauth1WithEmail(email: "email", password: "password");
      when(mockClient.createOAuth1TokenWithEmail(oautWithEmail))
          .thenAnswer((_) async => Response(authWithEmailResult, 200));
      when(mockClient.getGeneralConfiguration()).thenAnswer((_) async => Response(privacyDocumentV1, 200));
      when(mockClient.getUserConfiguration()).thenAnswer((_) async => Response(privacyDocumentV1, 200));

      await sdk.authenticateWithEmail(oautWithEmail, (e) => {});

      verify(mockClient.createOAuth1TokenWithEmail(any)).called(1);
    });

    test("should authenticate a user and update legal docs", () async {
      var oautWithEmail = ParamsOauth1WithEmail(email: "email", password: "password");
      when(mockClient.createOAuth1TokenWithEmail(oautWithEmail))
          .thenAnswer((_) async => Response(authWithEmailResult, 200));
      when(mockClient.getGeneralConfiguration()).thenAnswer((_) async => Response(privacyDocumentV2, 200));
      when(mockClient.getUserConfiguration()).thenAnswer((_) async => Response(privacyDocumentV1, 200));
      when(mockClient.updateUserConfig(any)).thenAnswer((_) async => Response(affected1Record, 200));

      await sdk.authenticateWithEmail(
          oautWithEmail,
          (e) async => {
                for (var document in e)
                  {await sdk.giveConsent(document), verify(mockClient.updateUserConfig(any)).called(1)}
              });

      verify(mockClient.createOAuth1TokenWithEmail(any)).called(1);
    });

    test("should update legal docs", () async {
      when(mockClient.updateUserConfig(any)).thenAnswer((_) async => Response(affected1Record, 200));
      var document = Consent(legalDocumentKey: "legalDocumentKey", version: "version", url: "url");

      await sdk.giveConsent(document);

      verify(mockClient.updateUserConfig(any)).called(1);
    });
  });
}
