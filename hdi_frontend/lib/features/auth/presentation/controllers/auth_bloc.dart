import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasource/auth_api.dart';
import '../../data/storage/token_storage.dart';
import 'auth_state.dart';
import 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AuthApi authApi = AuthApi();

  AuthBloc() : super(AuthInitial()) {

    on<LoginRequested>(_login);

    on<LogoutRequested>(_logout);

    on<CheckLoginStatus>(_checkLogin);

    on<RefreshTokenRequested>(_refresh);

  }
  Future<void> _login(
      LoginRequested event,
      Emitter<AuthState> emit,
      ) async {

    emit(AuthLoading());

    try{

      final result = await authApi.login(
        phoneNumber: event.phoneNumber,
        password: event.password,
      );

      await TokenStorage.saveAccessToken(
        result["accessToken"],
      );

      await TokenStorage.saveRefreshToken(
        result["refreshToken"],
      );

      emit(AuthAuthenticated());

    }catch(e){

      emit(AuthFailure(e.toString()));

    }

  }
  Future<void> _logout(
      LogoutRequested event,
      Emitter<AuthState> emit,
      ) async {

    emit(AuthLoading());

    try{

      final token =
      await TokenStorage.getRefreshToken();

      if(token != null){

        await authApi.logout(
          refreshToken: token,
        );

      }

      await TokenStorage.logout();

      emit(AuthUnauthenticated());

    }catch(e){

      emit(AuthFailure(e.toString()));

    }

  }
  Future<void> _checkLogin(
      CheckLoginStatus event,
      Emitter<AuthState> emit,
      ) async {

    final accessToken = await TokenStorage.getAccessToken();

    if (accessToken != null && accessToken.isNotEmpty) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnauthenticated());
    }
  }
  Future<void> _refresh(
      RefreshTokenRequested event,
      Emitter<AuthState> emit,
      ) async {

    try {

      final refreshToken = await TokenStorage.getRefreshToken();

      if (refreshToken == null) {
        emit(AuthUnauthenticated());
        return;
      }

      final result = await authApi.refreshToken(
        refreshToken: refreshToken,
      );

      await TokenStorage.saveAccessToken(
        result["accessToken"],
      );

      emit(AuthAuthenticated());

    } catch (e) {

      emit(AuthUnauthenticated());

    }
  }

}
