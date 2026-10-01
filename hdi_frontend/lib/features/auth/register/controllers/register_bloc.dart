import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasource/auth_api.dart';
import '../../data/services/firebase_auth_service.dart';

import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final FirebaseAuthService firebaseAuthService = FirebaseAuthService();

  final AuthApi authApi = AuthApi();

  RegisterBloc() : super(RegisterInitial()) {

    /// ==========================
    /// GỬI OTP
    /// ==========================
    on<SendRegisterOtpRequested>((event, emit) async {

      emit(RegisterLoading());

      try {
        final verificationId =
        await firebaseAuthService.sendOtp(
          phoneNumber: formatPhone(event.phoneNumber),
        );
        emit(RegisterOtpSent(verificationId));
      } catch (e) {

        emit(RegisterOtpFailure("Không gửi được OTP"));

      }

    });

    /// ==========================
    /// VERIFY OTP + ĐĂNG KÝ
    /// ==========================
    on<VerifyRegisterOtpRequested>((event, emit) async {

      emit(RegisterLoading());

      try {

        await firebaseAuthService.verifyOtp(
          verificationId: event.verificationId,
          otp: event.otp,
        );

        final firebaseToken =
        await firebaseAuthService.getIdToken();

        await authApi.register(
          firebaseToken: firebaseToken,
          fullName: event.fullName,
          phoneNumber: event.phoneNumber.trim(),
          password: event.password,
        );

        emit(RegisterSuccess());

      }

      on FirebaseAuthException catch (e) {

        switch (e.code) {

          case "invalid-verification-code":
            emit(RegisterOtpFailure("Mã OTP không chính xác"));
            break;

          case "session-expired":
            emit(RegisterOtpFailure("Mã OTP đã hết hạn"));
            break;

          case "too-many-requests":
            emit(RegisterOtpFailure(
                "Bạn đã nhập sai quá nhiều lần. Vui lòng thử lại sau."
            ));
            break;

          case "network-request-failed":
            emit(RegisterOtpFailure("Không có kết nối Internet"));
            break;

          default:
            emit(RegisterOtpFailure(
              e.message ?? "Xác thực OTP thất bại",
            ));
        }

      }

      on DioException catch (e) {

        String message = "Có lỗi xảy ra";

        if (e.response?.data is Map<String, dynamic>) {
          message = e.response!.data["message"] ?? message;
        }

        emit(RegisterApiFailure(message));

      }

      catch (e) {

        emit(RegisterApiFailure("Có lỗi xảy ra"));

      }

    });

  }

  String formatPhone(String phone) {
    phone = phone.trim();
    if (phone.startsWith("+84")) {
      return phone;
    }
    if (phone.startsWith("0")) {
      return "+84${phone.substring(1)}";
    }
    return "+84$phone";
  }
}