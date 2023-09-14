import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:secure_doinz/controllers/auth_controller.dart';
import 'package:secure_doinz/controllers/user_token_controller.dart';
import 'package:secure_doinz/models/token_model.dart';
import 'package:secure_doinz/repositories/auth_repository.dart';

//! the auth repo provider
final Provider<AuthRepository> authRepositoryProvider =
    Provider((ref) => AuthRepository(ref: ref));

//! provider for the User token controller
final StateNotifierProvider<UserTokenController, UserToken?>
    userTokenControllerProvider = StateNotifierProvider(
  (ref) => UserTokenController(userTokenControllerRef: ref),
);

//! PROVIDER TO HOLD AES KEY
final Provider<encrypt.Key> aesKeyProvider = Provider<encrypt.Key>((ref) {
  final randomBytes =
      List<int>.generate(32, (i) => Random.secure().nextInt(256));
  return encrypt.Key(Uint8List.fromList(randomBytes));
});

//! the auth controller provider
final StateNotifierProvider<AuthController, bool> authControllerProvider =
    StateNotifierProvider(
  (ref) => AuthController(
    controllerRef: ref,
    authRepository: ref.watch(authRepositoryProvider),
  ),
);
