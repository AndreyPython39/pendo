import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:crypto/crypto.dart';

class EncryptionService {
  late final Key _key;
  late final IV _iv;
  late final Encrypter _encrypter;

  EncryptionService() {
    // Generate key from secure random string
    final keyString = _generateSecureKey();
    _key = Key.fromUtf8(keyString);
    _iv = IV.fromLength(16);
    _encrypter = Encrypter(AES(_key));
  }

  String encrypt(String data) {
    return _encrypter.encrypt(data, iv: _iv).base64;
  }

  String decrypt(String encryptedData) {
    final encrypted = Encrypted.fromBase64(encryptedData);
    return _encrypter.decrypt(encrypted, iv: _iv);
  }

  String hash(String data) {
    return sha256.convert(utf8.encode(data)).toString();
  }

  bool verifyHash(String data, String hash) {
    return this.hash(data) == hash;
  }

  String _generateSecureKey() {
    final key = Key.fromSecureRandom(32);
    return base64Url.encode(key.bytes);
  }

  // Encrypt map
  Map<String, dynamic> encryptMap(Map<String, dynamic> data) {
    final encryptedData = <String, dynamic>{};
    data.forEach((key, value) {
      if (value is String) {
        encryptedData[key] = encrypt(value);
      } else {
        encryptedData[key] = value;
      }
    });
    return encryptedData;
  }

  // Decrypt map
  Map<String, dynamic> decryptMap(Map<String, dynamic> encryptedData) {
    final decryptedData = <String, dynamic>{};
    encryptedData.forEach((key, value) {
      if (value is String) {
        try {
          decryptedData[key] = decrypt(value);
        } catch (e) {
          decryptedData[key] = value;
        }
      } else {
        decryptedData[key] = value;
      }
    });
    return decryptedData;
  }
}
