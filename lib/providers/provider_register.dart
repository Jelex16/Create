import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:match_home_client/api/api.dart';
import 'package:match_home_client/config/config.dart';
import 'package:match_home_client/models/models.dart';
import 'package:match_home_client/shared/utils/utils.dart';
import 'package:match_home_client/shared/validator/validator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider_register.g.dart';

@riverpod
class LoadRegister extends _$LoadRegister {
  bool isValid = false;
  @override
  UserModelRegister build() {
    return UserModelRegister();
  }

  void setUrlProfile(String urlProfile) {
    state = state.copyWith(urlProfile: urlProfile);
  }

  void setName(String name) {
    state = state.copyWith(name: GeneralField.dirty(name));
    isValid = Formz.validate([
      state.name ?? const GeneralField.dirty(''),
      state.phone ?? const TelePhone.pure(),
      state.inmobiliario ?? const GeneralField.pure(),
      state.ciudad ?? const GeneralField.pure(),
      state.email ?? const Email.pure(),
      state.password ?? const Password.pure(),
    ]);
  }

  void setPhone(String phone) {
    state = state.copyWith(phone: TelePhone.dirty(phone));
    isValid = Formz.validate([
      state.name ?? const GeneralField.dirty(''),
      state.phone ?? const TelePhone.pure(),
      state.inmobiliario ?? const GeneralField.pure(),
      state.ciudad ?? const GeneralField.pure(),
      state.email ?? const Email.pure(),
      state.password ?? const Password.pure(),
    ]);
  }

  void setInmobiliario(String inmobiliario) {
    state = state.copyWith(inmobiliario: GeneralField.dirty(inmobiliario));
    isValid = Formz.validate([
      state.name ?? const GeneralField.dirty(''),
      state.phone ?? const TelePhone.pure(),
      state.inmobiliario ?? const GeneralField.pure(),
      state.ciudad ?? const GeneralField.pure(),
      state.email ?? const Email.pure(),
      state.password ?? const Password.pure(),
    ]);
  }

  void setCiudad(String ciudad) {
    state = state.copyWith(ciudad: GeneralField.dirty(ciudad));
    isValid = Formz.validate([
      state.name ?? const GeneralField.dirty(''),
      state.phone ?? const TelePhone.pure(),
      state.inmobiliario ?? const GeneralField.pure(),
      state.ciudad ?? const GeneralField.pure(),
      state.email ?? const Email.pure(),
      state.password ?? const Password.pure(),
    ]);
  }

  void setUrlAvatar(String urlAvatar) {
    state = state.copyWith(urlAvatar: urlAvatar);
  }

  void setEmail(String email) {
    state = state.copyWith(email: Email.dirty(email));
    isValid = Formz.validate([
      state.name ?? const GeneralField.dirty(''),
      state.phone ?? const TelePhone.pure(),
      state.inmobiliario ?? const GeneralField.pure(),
      state.ciudad ?? const GeneralField.pure(),
      state.email ?? const Email.pure(),
      state.password ?? const Password.pure(),
    ]);
  }

  void setPassword(String password) {
    state = state.copyWith(password: Password.dirty(password));
    isValid = Formz.validate([
      state.name ?? const GeneralField.dirty(''),
      state.phone ?? const TelePhone.pure(),
      state.inmobiliario ?? const GeneralField.pure(),
      state.ciudad ?? const GeneralField.pure(),
      state.email ?? const Email.pure(),
      state.password ?? const Password.pure(),
    ]);
  }

  Future<void> register(
      BuildContext context, File? imageFile, File? imageFileAvatar) async {
    if (!isValid) {
      CustomSnackbar.showSnackBar(
          'Todos los campos son obligatorios',
          // ignore: use_build_context_synchronously
          context,
          isSuccess: false);
      return;
    }
    final authInstance = ApiAuth();
    final apiImages = ApiLoadImages();
    final response = await authInstance.registerUser(
        state.email!.value, state.password!.value);
    if (!response['success']) {
      // ignore: use_build_context_synchronously
      CustomSnackbar.showSnackBar(response['message'], context,
          isSuccess: false);
      return;
    }
    final user = response['user'] as UserCredential;
    final uid = user.user!.uid;
    final urlImages =
        await apiImages.uploadImages([imageFile!, imageFileAvatar!]);
    state = state.copyWith(urlProfile: urlImages[0]);
    state = state.copyWith(urlAvatar: urlImages[1]);
    await authInstance.addUser(state, uid);
    GeneralUtils.setUid(uid);
    // ignore: use_build_context_synchronously
    context.go(PathRouter.welcomePage);
    return;
  }
}
