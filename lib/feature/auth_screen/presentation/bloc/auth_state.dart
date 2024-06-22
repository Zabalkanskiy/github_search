 import 'dart:ffi';
//
// class AuthState {
//   String? name;
//   String? password;
//   String? error;
//   bool loading = true;
//
//   AuthState({required this.name, required this.password, required this.error, required this.loading });
//
// }

abstract class AuthState {}

class AuthLoading extends AuthState {}

class AuthSignInError extends AuthState {
  final String error;

  AuthSignInError(this.error);
}

class AuthAutoSignIn extends AuthState {
  AuthAutoSignIn();
}

class AuthSignIn extends AuthState {
  AuthSignIn();
}
class AuthCompleted extends AuthState {
 final String token;
 AuthCompleted(this.token);
}