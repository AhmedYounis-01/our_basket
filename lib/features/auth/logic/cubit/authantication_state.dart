part of 'authantication_cubit.dart';

sealed class AuthanticationState extends Equatable {
  const AuthanticationState();

  @override
  List<Object> get props => [];
}

final class AuthanticationInitial extends AuthanticationState {}

final class LoginLoading extends AuthanticationState {}

final class LoginSuccess extends AuthanticationState {}

final class LoginError extends AuthanticationState {
  final String msg;

  const LoginError(this.msg);
}

final class RegisterLoading extends AuthanticationState {}
 
final class RegisterSuccess extends AuthanticationState {}

final class RegisterError extends AuthanticationState {
  final String msg;

  const RegisterError(this.msg);
}
