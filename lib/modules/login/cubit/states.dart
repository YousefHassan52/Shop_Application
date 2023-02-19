import 'package:shop_app/models/login_model/login_model.dart';

abstract  class LoginStates{}

class LoginInitialState extends LoginStates{}

class LoginSuccessfullState extends LoginStates{
  final LoginModel loginModel;

  LoginSuccessfullState(this.loginModel);
}
class LoginLoadingState extends LoginStates{}

class LoginErrorState extends LoginStates{
  final String error;
  LoginErrorState(this.error);
}

class LoginChangePasswordIconState extends LoginStates{}