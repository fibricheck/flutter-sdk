import 'dart:convert';
import 'package:crypto/crypto.dart';

typedef Sign = String Function(String key, String text);

class SignatureMethod {
  /// Signature Method Name
  final String name;

  /// Sign data by key.
  final Sign sign;

  /// A constructor of SignatureMethod.
  SignatureMethod(this.name, this.sign);
}

abstract class SignatureMethods {
  /// http://tools.ietf.org/html/rfc5849#section-3.4.2
  static final SignatureMethod hmacSha1 = SignatureMethod("HMAC-SHA1", (key, text) {
    Hmac hmac = Hmac(sha1, key.codeUnits);
    List<int> bytes = hmac.convert(text.codeUnits).bytes;

    // The output of the HMAC signing function is a binary
    // string. This needs to be base64 encoded to produce
    // the signature string.
    return base64Encode(bytes);
  });

  /// http://tools.ietf.org/html/rfc5849#section-3.4.3
  /// http://tools.ietf.org/html/rfc5849#section-3.4.4
  static final SignatureMethod plaintext = SignatureMethod("PLAINTEXT", (key, text) {
    return key;
  });
}
