import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'dart:developer';
part 'authantication_state.dart';

class AuthanticationCubit extends Cubit<AuthanticationState> {
  AuthanticationCubit() : super(AuthanticationInitial());
  SupabaseClient client = Supabase.instance.client;

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
}
