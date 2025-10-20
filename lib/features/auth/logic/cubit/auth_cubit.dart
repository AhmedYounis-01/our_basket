import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'dart:developer';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  SupabaseClient client = Supabase.instance.client;

  late final GoogleSignIn _googleSignIn;
  static const String _webClientId =
      '374149477447-pkn1s21gar8q7a2mcrpc9j4e01lcvelh.apps.googleusercontent.com';

  void _initializeGoogleSignIn() {
    _googleSignIn = GoogleSignIn.instance;
    unawaited(_googleSignIn.initialize(serverClientId: _webClientId));
  }

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await client.auth.signInWithPassword(email: email, password: password);
      emit(LoginSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(LoginError(e.toString()));
    } catch (e) {
      log(e.toString());
      emit(LoginError(e.toString()));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    try {
      await client.auth.signUp(email: email, password: password);
      emit(RegisterSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(RegisterError(e.toString()));
    } catch (e) {
      log(e.toString());
      emit(RegisterError(e.toString()));
    }
  }

  Future<AuthResponse> googleSignIn() async {
    emit(GoogleSignInLoading());

    try {
      // تأكد من تهيئة GoogleSignIn
      _initializeGoogleSignIn();

      // تسجيل الدخول
      final googleAccount = await _googleSignIn.authenticate();

      // ignore: unnecessary_null_comparison
      if (googleAccount == null) {
        emit(GoogleSignInError());
        return AuthResponse();
      }

      // الحصول على التوكنات
      final googleAuthentication = googleAccount.authentication;
      final idToken = googleAuthentication.idToken;

      if (idToken == null) {
        emit(GoogleSignInError());
        return AuthResponse();
      }

      // الحصول على Access Token
      final googleAuthorization = await googleAccount.authorizationClient
          .authorizationForScopes(['email', 'profile']);
      final accessToken = googleAuthorization?.accessToken;

      // تسجيل الدخول عبر Supabase
      AuthResponse response = await client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      emit(GoogleSignInSuccess());
      return response;
    } on AuthException catch (e) {
      log(e.toString());
      emit(GoogleSignInError());
      return AuthResponse();
    } catch (e) {
      log(e.toString());
      emit(GoogleSignInError());
      return AuthResponse();
    }
  }

  Future<void> logout() async {
    try {
      emit(LogoutLoading());
      await client.auth.signOut();
      emit(LogoutSuccess());
    } catch (e) {
      log('Sign-Out Error: $e');
      emit(LogoutError());
    }
  }

  Future<void> resetPassword({required String email}) async {
    emit(ResetPassLoading());
    try {
      await client.auth.resetPasswordForEmail(email);
      emit(ResetPassSuccess());
    } catch (e) {
      log(e.toString());
      emit(ResetPassError());
    }
  }

  //!!! For udemy course

  // GoogleSignInAccount? googleUser;
  // Future<AuthResponse> googleSignInn() async {
  //   emit(GoogleSignInLoading());
  //   const webClientId =
  //       '374149477447-pkn1s21gar8q7a2mcrpc9j4e01lcvelh.apps.googleusercontent.com';
  //   final GoogleSignIn googleSignIn = GoogleSignIn(
  //     // clientId: iosClientId,
  //     serverClientId: webClientId,
  //   );
  //   if (googleUser == null) {
  //     return AuthResponse();
  //   }
  //   googleUser = await googleSignIn.signIn();
  //   final googleAuth = await googleUser!.authentication;
  //   final accessToken = googleAuth.accessToken;
  //   final idToken = googleAuth.idToken;
  //   if (accessToken == null || idToken == null) {
  //     emit(GoogleSignInError());
  //     return AuthResponse();
  //   }
  //   AuthResponse response = await client.auth.signInWithIdToken(
  //     provider: OAuthProvider.google,
  //     idToken: idToken,
  //     accessToken: accessToken,
  //   );
  //   emit(GoogleSignInSucess());
  //   return response;
  // }
}
