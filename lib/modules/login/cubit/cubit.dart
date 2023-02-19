import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/cubit/cubit.dart';

class LoginCubit extends Cubit<LoginStates>{

  LoginCubit():super(LoginInitialState());
  static LoginCubit get(context)=>BlocProvider.of(context);
  var formKey=GlobalKey<FormState>();

  var emailCotroller=TextEditingController();
  var passwordCotroller=TextEditingController();
  LoginModel? loginModel;
  bool isPassword=true;
  IconData passwordPrefixIcon=Icons.remove_red_eye;
  changePasswordIcon()
  {
    isPassword=!isPassword;
    if(isPassword==true)
    {
      passwordPrefixIcon=Icons.remove_red_eye;
    }
    else
    {
        passwordPrefixIcon=Icons.visibility_off;
    }
    emit(LoginChangePasswordIconState());
  }

  void userLogin({
    required email,
    required password,
})
   {

    emit(LoginLoadingState());

     DioHelper.postData(
        url: LOGIN,
        data:
        {
          "email":"$email",
          "password":"$password",
        }
    ).then((value) {

      loginModel=LoginModel.fromJson(value.data);

      emit(LoginSuccessfullState(loginModel!));
    }).catchError((error)
    {
      emit(LoginErrorState(error.toString()));
      print(error.toString());
    });

  }






}