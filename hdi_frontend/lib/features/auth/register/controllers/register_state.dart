abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

/// Đã gửi OTP
class RegisterOtpSent extends RegisterState {
  final String verificationId;

  RegisterOtpSent(this.verificationId);
}

/// Đăng ký thành công
class RegisterSuccess extends RegisterState {}

class RegisterOtpFailure extends RegisterState {
  final String error;

  RegisterOtpFailure(this.error);
}
class RegisterApiFailure extends RegisterState {
  final String error;

  RegisterApiFailure(this.error);
}