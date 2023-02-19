import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

import '../../layout/shop_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cash_helper.dart';
import '../../shared/styles/colors.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit=RegisterCubit.get(context);
    return  BlocConsumer<RegisterCubit,RegisterStates>(

        listener: (context,state){
          if(state is GetUserDataSuccesState)
          {
            if (state.loginModel.status==true)
            {
              CacheHelper.saveData(key: 'token', value:state.loginModel.data!.token ).then((value) {
                token=state.loginModel.data!.token!;
               AppCubit.get(context).getAllScreensDataAfterSigninOrRegister();
              });
              print(state.loginModel.data!.name);
              toast(text: state.loginModel.message!, color: mainColor).then((value) {

                      navigateToAndReplace(context, ShopLayout());
                    });
            }
          }
          // if(state is RegisterSuccessfullState && token!=null)
          // {
          //   if(state.loginModel.status==true)
          //   {
          //     print(state.loginModel.message);
          //     print(state.loginModel.data!.name);
          //     CacheHelper.saveData(key: 'token', value:state.loginModel.data!.token );
          //
          //
          //     toast(text: state.loginModel.message!, color: mainColor).then((value) {
          //       navigateTo(context, ShopLayout());
          //     });
          //     // roo7 screen el home
          //
          //   }
          //   else
          //   {
          //     navigateToAndReplace(context, LoginScreen());
          //     print(state.loginModel.message);
          //     print(state.loginModel.status);
          //
          //     toast(text: state.loginModel.message!, color: Colors.red);
          //   }
          // }
        },
        builder: (context,state){
          return Scaffold(
            body: Form(
              key: cubit.formKey,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        defaultTextFormField(
                          controller: cubit.nameController,
                          validate: (value) {
                            if (value == null || value.isEmpty)
                              return "name required";
                          },
                          text: "name",
                          prefixIcon: Icons.person,
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(
                          controller: cubit.emailController,
                          validate: (value) {
                            if (value == null || value.isEmpty)
                              return "email required";
                          },
                          text: "email",
                          prefixIcon: Icons.person,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(
                          controller: cubit.phoneController,
                          validate: (value) {
                            if (value == null || value.isEmpty)
                              return "phone required";
                          },
                          text: "phone",
                          prefixIcon: Icons.phone,
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(
                          controller: cubit.passwordController,
                          validate: (value) {
                            if (value == null || value.isEmpty)
                              return "password required";
                          },
                          text: "password",
                          suffix: cubit.passwordSuffixIcon,
                          prefixIcon: Icons.lock,
                          keyboardType: TextInputType.visiblePassword,
                          isPassword: cubit.isPassword,
                          suffixPressed: (){cubit.changePasswordIcon();},
                        ),
                        SizedBox(height: 25,),
                        defaultButton(function: (){

                          if(cubit.formKey.currentState!.validate())
                          {
                            cubit.register(
                              name: cubit.nameController.text,
                              email: cubit.emailController.text,
                              phone: cubit.phoneController.text,
                              password: cubit.passwordController.text,
                            );

                          }
                        }, text: "signup")
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
    );
  }
}
