import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var cubit=AppCubit.get(context);
    return BlocConsumer<AppCubit,AppStates>(

      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: Text("Vstore",style: TextStyle(fontSize: 32 ,color: Colors.white),),
            actions: [


              IconButton(onPressed: (){navigateTo(context, SearchScreen());}, icon:Icon( Icons.search_rounded)),
            ],

          ),
          body:cubit.screens[cubit.currentIndex] ,
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.navBarItems,
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNav(index);
            },
          ),
          // body: ,
        );
      },
      listener: (context,state){},
    );
  }
}
