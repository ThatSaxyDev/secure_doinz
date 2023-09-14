import 'dart:collection';

import 'package:flutter/foundation.dart';

class UserToken extends MapView<String, dynamic> {
  late String? token;

  UserToken({this.token})
      : super({UserTokenModelFieldName.sessionToken: token});

  UserToken.fromJSON({
    required Map<String, dynamic> json,
  }) : this(
          token: json[UserTokenModelFieldName.sessionToken] ?? "",
        );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserToken &&
          runtimeType == other.runtimeType &&
          token == other.token;

  @override
  int get hashCode => Object.hashAll([
        token,
      ]);
}

@immutable
class UserTokenModelFieldName {
  static const String sessionToken = "token";

  const UserTokenModelFieldName._();
}
