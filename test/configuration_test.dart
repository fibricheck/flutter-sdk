// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter_fibricheck_sdk/api/httpclient.dart';
import 'package:flutter_fibricheck_sdk/flutter_fibricheck_sdk.dart';
import 'package:flutter_fibricheck_sdk/general_configuration.dart';
import 'package:flutter_fibricheck_sdk/user_configuration.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:collection/collection.dart';

import 'measurement_test.mocks.dart';
import 'test_data.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([OAuth1Client])
void main() {
  var mockClient = MockOAuth1Client(); 
  var sdk = FLFibriCheckSdk(mockClient);

  when(mockClient.consumerKey).thenReturn("key");
  when(mockClient.consumerSecret).thenReturn("secret");

  group("configuration", () {
    test("should get a GeneralConfiguration instance", () async {
      when(mockClient.getGeneralConfiguration()).thenAnswer(
        (_) async => Response(generalConfigurationData, 200));

      GeneralConfiguration generalConfiguration = await sdk.getGeneralConfiguration();
      
      Map<String, dynamic> originalConfigurationJson = jsonDecode(generalConfigurationData);
      Map<String, dynamic> fetchedConfigurationJson = generalConfiguration.toJson();

      expect(const DeepCollectionEquality().equals(originalConfigurationJson, fetchedConfigurationJson), true);
    });

    test("should get the user configuration as a json", () async {
      when(mockClient.getUserConfiguration(any)).thenAnswer(
        (_) async => Response(userConfigurationData, 200));

      UserConfiguration userConfiguration = await sdk.getUserConfiguration();

      Map<String, dynamic> originalConfigurationJson = jsonDecode(userConfigurationData);
      Map<String, dynamic> fetchedConfigurationJson = userConfiguration.toJson();

      expect(const DeepCollectionEquality().equals(originalConfigurationJson, fetchedConfigurationJson), true);
    });

    test('should update properly the user configuration', () async {
      when(mockClient.updateUserConfig(any, any)).thenAnswer(
        (_) async => Response(affected1Record, 200));

      bool isUserConfigurationUpdated = await sdk.updateUserConfig('key', 'value');

      expect(isUserConfigurationUpdated, true);
    });
  });
}
