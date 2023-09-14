import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secure_doinz/providers/auth_providers.dart';

class SessionTokenEncrypter {
  static const String _padding = "PKCS7";

  static String encryptToken({
    required String sessionToken,
    required Ref callerRef,
  }) {
    final encrypt.IV initializationVector = encrypt.IV.fromLength(16);
    final encrypt.Encrypter aesEncrypter = encrypt.Encrypter(
      encrypt.AES(
        callerRef.read(aesKeyProvider),
        mode: encrypt.AESMode.cbc,
        padding: _padding,
      ),
    );

    final encrypt.Encrypted encrypted =
        aesEncrypter.encrypt(sessionToken, iv: initializationVector);
    return encrypted.base64;
  }

  static String decryptData({
    required String encryptedSessionToken,
    required Ref callerRef,
  }) {
    final encrypt.IV initializationVector = encrypt.IV.fromLength(16);
    final encrypt.Encrypter aesEncrypter = encrypt.Encrypter(
      encrypt.AES(
        callerRef.read(aesKeyProvider),
        mode: encrypt.AESMode.cbc,
        padding: _padding,
      ),
    );

    final String decryptedSessionToken =
        aesEncrypter.decrypt64(encryptedSessionToken, iv: initializationVector);

    return decryptedSessionToken;
  }
}
