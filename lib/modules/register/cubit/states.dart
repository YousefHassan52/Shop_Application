import 'package:shop_app/models/login_model/login_model.dart';

abstract class RegisterStates{}
class InitialRegisterState extends RegisterStates{}
class GetUserDataSuccesState extends RegisterStates{
  LoginModel loginModel;

  GetUserDataSuccesState(this.loginModel);
}
class GetUserDataloadingState extends RegisterStates{}
class GetUserDataErrorState extends RegisterStates{
  final String error;

  GetUserDataErrorState(this.error);
}
class RegisterChangePasswordIconState extends RegisterStates{}