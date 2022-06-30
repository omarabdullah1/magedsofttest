part of 'global_cubit.dart';

@immutable
abstract class GlobalState {}

class GlobalInitial extends GlobalState {}

class LoginLoadingState extends GlobalState {}

class LoginSuccessState extends GlobalState {
  final AccountModel loginModel;
  LoginSuccessState(this.loginModel);
}
class LoginErrorState extends GlobalState {
  final String error;
  LoginErrorState(this.error);
}
class RegisterLoadingState extends GlobalState {}

class RegisterSuccessState extends GlobalState {}

class RegisterErrorState extends GlobalState {
  final String error;
  RegisterErrorState(this.error);
}

class ChangePasswordVisibilityState extends GlobalState {}

class AppChangeLanguageState extends GlobalState {}
