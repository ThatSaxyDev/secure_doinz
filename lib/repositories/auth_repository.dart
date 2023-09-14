import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secure_doinz/models/token_model.dart';
import 'package:secure_doinz/providers/auth_providers.dart';

class AuthRepository {
  final Ref _ref;
  const AuthRepository({required Ref ref})
      : _ref = ref,
        super();

  //! sign up user
  //! a future
  Future<bool> signUpUser() async {
    //! MAKE REQUEST
    //! SEND REQUEST
    int responseStatusCode = 0;
    String tokenFromJson =
        'wecwevwhjcwe73723gfh82egcb82727jcdscasc.ashcuyqwe7qhcehe';

    await Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      responseStatusCode = 200;
    });

    switch (responseStatusCode) {
      //! SERVER REQUEST WAS SUCCESSFUL
      case 200:
        //! CONVERT DATA TO MODEL AND GET TOKEN

        UserToken currentSessionToken = UserToken(token: tokenFromJson);

        //! UPDATE TOKEN STATE
        _ref
            .read(userTokenControllerProvider.notifier)
            .setUserToken(currentSessionToken: currentSessionToken);

        return true;

      //! UPDATE USER DATA STATE

      //! return whatever you would have returned if it was a future

      //! SERVER REQUEST FAILED
      case 400:
        return false;

      //! ANY OTHER FAILURE TYPE
      default:
        return false;
    }
  }

  //! to make random API call
  Future<void> apiCallANDPrintToken() async {
    //! FETCH USER TOKEN
    String? sessionToken =
        _ref.read(userTokenControllerProvider.notifier).getUserToken()?.token;

    print(sessionToken);

    //! http request header
    // ..headers.addAll({
    //   "Content-Type": "application/json; charset=UTF-8",
    //   "Authorization": "Bearer $sessionToken"
    // })
  }
}
