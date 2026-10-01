abstract class RegisterEvent {}

/// Gửi OTP
class SendRegisterOtpRequested extends RegisterEvent {
  final String fullName;
  final String phoneNumber;
  final String password;

  SendRegisterOtpRequested({
    required this.fullName,
    required this.phoneNumber,
    required this.password,
  });
}

/// Xác minh OTP
class VerifyRegisterOtpRequested extends RegisterEvent {
  final String verificationId;
  final String otp;

  final String fullName;
  final String phoneNumber;
  final String password;

  VerifyRegisterOtpRequested({
    required this.verificationId,
    required this.otp,
    required this.fullName,
    required this.phoneNumber,
    required this.password,
  });
}