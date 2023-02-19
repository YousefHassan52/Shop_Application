import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

import '../../shared/components/components.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit=AppCubit.get(context);
  return BlocConsumer<AppCubit,AppStates>(
      builder: (context,state){
        return cubit.homeModel!=null &&cubit.categoryModel!=null?
        productScreenBuilder(context,cubit.homeModel!,cubit.categoryModel!)
            :const Center(child: CircularProgressIndicator());
      },

      listener: (context,state){
        if(state is AppChangeFavouritesSuccessState)
          {
            if(state.model.status==false)
              {
                toast(text: state.model.message!, color: Colors.yellow);
              }
          }
      },);
  }
}
