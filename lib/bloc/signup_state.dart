part of 'signup_cubit.dart';

@immutable
abstract class SignupStates {}

class SignupInitial extends SignupStates {}

class PasswordVisibility extends SignupStates {}

class SignupLoading extends SignupStates {}

class SignupSuccess extends SignupStates {}

class SignupError extends SignupStates {
  final String errorMessage;

  SignupError(this.errorMessage);
}
