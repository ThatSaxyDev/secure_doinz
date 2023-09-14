
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secure_doinz/controllers/session_token_encrypter.dart';
import 'package:secure_doinz/models/token_model.dart';

class UserTokenController extends StateNotifier<UserToken?> {
  UserTokenController({
    required this.userTokenControllerRef,
  }) : super(null);

  Ref userTokenControllerRef;

  Future<void> setUserToken({required UserToken currentSessionToken}) async {
    UserToken sessionTokenEncrypted = UserToken(
      token: SessionTokenEncrypter.encryptToken(
        sessionToken: currentSessionToken.token!,
        callerRef: userTokenControllerRef,
      ),
    );

    state = sessionTokenEncrypted;
  }

  UserToken? getUserToken() {
    UserToken sessionTokenDecrypted = UserToken(
      token: SessionTokenEncrypter.decryptData(
        encryptedSessionToken: state!.token!,
        callerRef: userTokenControllerRef,
      ),
    );

    return sessionTokenDecrypted;
  }

  void eraseSessionToken() => state = null;
}
