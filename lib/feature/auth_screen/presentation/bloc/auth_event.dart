abstract class AuthEvent {}

class CheckSignIn extends AuthEvent {}

class GetToken extends AuthEvent {
  final String token;
  GetToken(this.token);
}

class GetError extends AuthEvent{
  final String error;
  GetError(this.error);
}

class Logout extends AuthEvent {}