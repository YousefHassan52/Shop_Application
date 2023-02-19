import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

import '../../../shared/components/constants.dart';

class RegisterCubit extends Cubit<RegisterStates>{

  RegisterCubit():super(InitialRegisterState());

  static RegisterCubit get(context)=>BlocProvider.of(context);
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();
  var passwordController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  LoginModel? loginModel;
  bool isPassword=true;
  IconData passwordSuffixIcon=Icons.remove_red_eye;
  changePasswordIcon()
  {
    isPassword=!isPassword;
    if(isPassword==true)
    {
      passwordSuffixIcon=Icons.remove_red_eye;
    }
    else
    {
        passwordSuffixIcon=Icons.visibility_off;
    }
    emit(RegisterChangePasswordIconState());
  }

  void register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }){
    emit(GetUserDataloadingState());
    DioHelper.postData(url: REGISTER, data: {
      "name":name,
      "email":email,
      "phone":phone,
      "password":password
    }).then((value) {
      loginModel=LoginModel.fromJson(value.data);
      emit(GetUserDataSuccesState(loginModel!));


    }).catchError((error){
      emit(GetUserDataErrorState(error.toString()));
    });

  }





}