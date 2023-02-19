import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

import '../../shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit=AppCubit.get(context);



    return BlocConsumer<AppCubit,AppStates>(
        builder:(context,state){
          if (cubit.userData!=null) {
            var formKey=GlobalKey<FormState>();
            nameController.text = cubit.userData!.data!.name!;
            phoneController.text = cubit.userData!.data!.phone!;
            emailController.text = cubit.userData!.data!.email!;
            return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key:formKey ,
              child: Column(
                children: [
                  if(state is AppUpdateProfileLoadingState) LinearProgressIndicator(),
                    SizedBox(height: 5,),

                    defaultTextFormField(
                      controller: nameController,
                      validate: (value)
                      {
                        if(value==null||value.isEmpty)
                          return "Name is required";

                      },
                      text: "Full Name",
                      prefixIcon: Icons.person ,
                      keyboardType: TextInputType.text
                  ),
                  SizedBox(height: 15),
                  defaultTextFormField(
                      controller: emailController,
                      validate: (value)
                      {
                        if(value==null||value.isEmpty)
                          return "Email Address is required";

                      },
                      text: "Email Address",
                      prefixIcon: Icons.alternate_email_sharp ,
                      keyboardType: TextInputType.emailAddress
                  ),
                  SizedBox(height: 15),
                  defaultTextFormField(
                      controller: phoneController,
                      validate: (value)
                      {
                        if(value==null||value.isEmpty)
                          return "Phone number is required";

                      },
                      text: "Phone number",
                      prefixIcon: Icons.phone ,
                      keyboardType: TextInputType.phone
                  ),
                  SizedBox(height: 30),
                  defaultButton(function: (){cubit.signOut(context);}, text: "SIGNOUT"),
                  SizedBox(height: 15),

                  defaultButton(function: (){
                    if(formKey.currentState!.validate())
                    cubit.updateUserData(name: nameController.text, email: emailController.text, phone: phoneController.text);


                  }, text: "Update")

                ],
              ),
            ),
          );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        } ,
        listener:(context,state){

        } );
  }
}
