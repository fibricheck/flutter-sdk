import 'dart:convert';
import 'package:crypto/crypto.dart';

typedef String Sign(String key, String text);

class SignatureMethod {
  final String _name;
  final Sign _sign;

  /// A constructor of SignatureMethod.
  SignatureMethod(this._name, this._sign);

  /// Signature Method Name
  String get name => _name;

  /// Sign data by key.
  String sign(String key, String text) => _sign(key, text);
}

abstract class SignatureMethods {
  /// http://tools.ietf.org/html/rfc5849#section-3.4.2
  static final SignatureMethod HMAC_SHA1 =
      SignatureMethod("HMAC-SHA1", (key, text) {
    Hmac hmac = Hmac(sha1, key.codeUnits);
    List<int> bytes = hmac.convert(text.codeUnits).bytes;

    // The output of the HMAC signing function is a binary
    // string. This needs to be base64 encoded to produce
    // the signature string.
    return base64Encode(bytes);
  });

  /// http://tools.ietf.org/html/rfc5849#section-3.4.3
  /// http://tools.ietf.org/html/rfc5849#section-3.4.4
  static final SignatureMethod PLAINTEXT =
      SignatureMethod("PLAINTEXT", (key, text) {
    return key;
  });
}
