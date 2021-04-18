import 'package:crypto/crypto.dart';
import 'package:sprintf/sprintf.dart';
import 'package:base32/base32.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';
import "dart:typed_data";

class OTPModel {
  String uuid;
  String name;
  String key;
  String value;

  OTPModel(String name, String key) {
    this.name = name;
    this.key = key;
    this.value = "";
    this.uuid = Uuid().v1();
  }

  void refresh(int counter) {
    var hmacSha1 = Hmac(sha1, base32.decode(key)); 
    var bytes = _int2bytes(counter); 
    var digest = hmacSha1.convert(bytes);

    int offset = digest.bytes[digest.bytes.length - 1] & 0xf;
    int binary =
        ((digest.bytes[offset] & 0x7f) << 24) |
        ((digest.bytes[offset + 1] & 0xff) << 16) |
        ((digest.bytes[offset + 2] & 0xff) << 8) |
        (digest.bytes[offset + 3] & 0xff);

    var _otpNumber = binary % (pow(10, 6));
    value = sprintf('%06d', [_otpNumber]);
  }

  List _int2bytes(int number) {
    var bdata = new ByteData(8);
    bdata.setInt64(0, number);
    return bdata.buffer.asInt8List();
  }
}
