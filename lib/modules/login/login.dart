import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/register.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


  var cubit=LoginCubit.get(context);

  return BlocConsumer<LoginCubit,LoginStates>(
    builder: (context,state){
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SafeArea(
            child: Form(
              key: cubit.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "LOGIN",
                    style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.black),
                  ),
                  const SizedBox(height: 30,),
                  Text(
                    "Login now to get our hot offers",
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 30,),
                  defaultTextFormField(
                    controller: cubit.emailCotroller,
                    validate: (value){
                      if(value==null || value.isEmpty) {
                        return "please write your email";
                      }
                      return null;
                    },
                    text: "Email",
                    prefixIcon: Icons.alternate_email_rounded,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10,),
                  defaultTextFormField(
                    submit: (value){
                    },
                    controller: cubit.passwordCotroller,
                    validate: (value){
                      if(value==null || value.isEmpty) {
                        return "short password...!";

                      }
                      return null;
                    },
                    text: "Password",
                    prefixIcon: Icons.lock_rounded,
                    keyboardType: TextInputType.emailAddress,
                    suffix: cubit.passwordPrefixIcon,
                    suffixPressed: (){
                      cubit.changePasswordIcon();
                    },
                    isPassword: cubit.isPassword,


                  ),
                  const SizedBox(height: 20,),

                  state is! LoginLoadingState? defaultButton(function: (){
                    if(cubit.formKey.currentState!.validate()==true)
                    {
                      cubit.userLogin(email: cubit.emailCotroller.text, password: cubit.passwordCotroller.text);


                    }
                  }, text: "login"):const Center(child: CircularProgressIndicator()),
                  Row(
                    children: [
                      Text("You don't have an acount.!?"),
                      TextButton(onPressed: (){
                        navigateTo(context, RegisterScreen());
                      }, child: Text("Sign-up"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
    listener: (context,state){
      // 2sl m4 ma3na 2n el code 200 y3ni howa 3amal login s7
      // momken yekon ba3at form el data s7 lkn el bayanat nafsha 8alat (incorrect password)
      if(state is LoginSuccessfullState)
      {
        if(state.loginModel.status==true)
        {
          print(state.loginModel.message);
          print(state.loginModel.data!.name);
          CacheHelper.saveData(key: 'token', value:state.loginModel.data!.token ).then((value) {
            token=state.loginModel.data!.token!;
            AppCubit.get(context).getAllScreensDataAfterSigninOrRegister();
          });



          toast(text: state.loginModel.message!, color: mainColor).then((value) {
            navigateToAndReplace(context, ShopLayout());
          });
          // roo7 screen el home

        }
        else
        {
          print(state.loginModel.message);
          print(state.loginModel.status);

          toast(text: state.loginModel.message!, color: Colors.red);
        }
      }
    },

  );
  }
}
