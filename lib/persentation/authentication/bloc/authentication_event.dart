part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

final class LoginButtonClickEvent extends AuthenticationEvent {
  final String email;
  final String password;

  LoginButtonClickEvent({
    required this.email,
    required this.password,
  });
}

final class SignupButtonClickEvent extends AuthenticationEvent {
  final String email;
  final String name;
  final String phone;
  final String password;

  SignupButtonClickEvent({
    required this.email,
    required this.name,
    required this.phone,
    required this.password,
  });
}
