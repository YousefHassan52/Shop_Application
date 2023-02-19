import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

import '../../shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var cubit=AppCubit.get(context);
    return BlocConsumer<AppCubit,AppStates>(
      builder: (context,state){
        return cubit.categoryModel!=null? Container(
          color: Colors.grey[300],
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
              itemBuilder: (context,index)=>categoryItem(cubit.categoryModel!.data!.dataModel[index]),
              separatorBuilder: (context,index)=>Container(
                height: 10,
              width: 5,
              color: Colors.grey[300],),
              itemCount: cubit.categoryModel!.data!.dataModel.length
          ),
        ):const Center(child: CircularProgressIndicator());
      },
      listener: (context,state){},
        
    );
  }
}
