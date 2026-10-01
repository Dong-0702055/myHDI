import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Gửi OTP
  Future<String> sendOtp({
    required String phoneNumber,
  }) async {

    final completer = Completer<String>();

    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,

      timeout: const Duration(seconds: 60),

      verificationCompleted: (credential) async {
        await _firebaseAuth.signInWithCredential(credential);
      },

      verificationFailed: (e) {
        completer.completeError(
          e.message ?? "Không gửi được OTP",
        );
      },

      codeSent: (verificationId, resendToken) {
        completer.complete(verificationId);
      },

      codeAutoRetrievalTimeout: (_) {},
    );

    return completer.future;
  }

  /// Xác minh OTP
  Future<UserCredential> verifyOtp({
    required String verificationId,
    required String otp,
  }) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );

    return await _firebaseAuth.signInWithCredential(credential);
  }

  /// Lấy Firebase ID Token
  Future<String> getIdToken() async {
    final token = await _firebaseAuth.currentUser?.getIdToken();
    if (token == null) {
      throw Exception("Không lấy được Firebase ID Token");
    }
    return token;
  }

  /// Đăng xuất Firebase
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}