import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secure_doinz/dialog_manager.dart';
import 'package:secure_doinz/repositories/auth_repository.dart';

class AuthController extends StateNotifier<bool> {
  final Ref _authControllerRef;
  final AuthRepository _authRepository;
  //! CONSTRUCTOR
  AuthController(
      {required Ref controllerRef, required AuthRepository authRepository})
      : _authControllerRef = controllerRef,
        _authRepository = authRepository,
        super(false);

  //!
  //! SIGN UP
  void signUpUser({required void Function()? sideEffect}) async {
    state = true;

    final res = await _authRepository.signUpUser();
    _authControllerRef.read(appSessionServiceProvider.notifier).countTime();

    state = false;

    if (res) {
      sideEffect!.call();
    }
  }
}
