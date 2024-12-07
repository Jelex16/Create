// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_auth.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authUserHash() => r'fe028a2fd12d13294a275ac99b29dda887d5023f';

/// See also [AuthUser].
@ProviderFor(AuthUser)
final authUserProvider =
    AutoDisposeNotifierProvider<AuthUser, AuthModel>.internal(
  AuthUser.new,
  name: r'authUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthUser = AutoDisposeNotifier<AuthModel>;
String _$updatePasswordHash() => r'776b023b01f8a3a14cefad0a70dd60aa4d2399a3';

/// See also [UpdatePassword].
@ProviderFor(UpdatePassword)
final updatePasswordProvider =
    AutoDisposeNotifierProvider<UpdatePassword, Password>.internal(
  UpdatePassword.new,
  name: r'updatePasswordProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$updatePasswordHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UpdatePassword = AutoDisposeNotifier<Password>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
