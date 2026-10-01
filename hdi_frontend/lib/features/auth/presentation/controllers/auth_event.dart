abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String phoneNumber;
  final String password;

  LoginRequested(this.phoneNumber, this.password);
}

class LogoutRequested extends AuthEvent {}

class CheckLoginStatus extends AuthEvent {}

class RefreshTokenRequested extends AuthEvent {}