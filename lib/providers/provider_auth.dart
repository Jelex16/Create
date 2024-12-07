import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:match_home_client/api/api.dart';
import 'package:match_home_client/models/models.dart';
import 'package:match_home_client/shared/utils/utils.dart';
import 'package:match_home_client/shared/validator/validator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider_auth.g.dart';

@riverpod
class AuthUser extends _$AuthUser {
  bool isValid = false;
  @override
  AuthModel build() {
    return AuthModel();
  }

  void setEmail(String email) {
    state = state.copyWith(email: Email.dirty(email));
    isValid = Formz.validate([
      state.email ?? const Email.dirty(''),
      state.password ?? const Password.pure()
    ]);
  }

  void setPassword(String password) {
    state = state.copyWith(password: Password.dirty(password));
    isValid = Formz.validate([
      state.email ?? const Email.dirty(''),
      state.password ?? const Password.pure()
    ]);
  }

  void reset() {
    state = AuthModel();
  }
}

@riverpod
class UpdatePassword extends _$UpdatePassword {
  bool isValid = false;
  Password password = const Password.pure();
  @override
  Password build() {
    return password;
  }

  void setPassword(String password) {
    state = Password.dirty(password);
    isValid = Formz.validate([state]);
  }

  Future<void> updatePassword(BuildContext context) async {
    if (!isValid) {
      // ignore: use_build_context_synchronously
      CustomSnackbar.showSnackBar('Contraseña inválida', context,
          isSuccess: false);
      return;
    }
    final api = ApiAuth();
    final result = await api.updatePassword(state.value);
    if (result['success']) {
      CustomSnackbar.showSnackBar(
        result['message'],
        // ignore: use_build_context_synchronously
        context,
      );
    } else {
      // ignore: use_build_context_synchronously
      CustomSnackbar.showSnackBar(result['message'], context, isSuccess: false);
    }
  }
}
