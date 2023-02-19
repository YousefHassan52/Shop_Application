import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

import '../../shared/components/components.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        if (state is! AppGetFavouritesLoadingState &&cubit.favouriteModel != null)
        {
          return favouriteScreenBuilder(cubit.favouriteModel!,context);
        }
        else
          return Center(child: CircularProgressIndicator(),);



      },
      listener: (context, state) {
        if (state is AppChangeFavouritesSuccessState) {
          if (state.model.status == false) {
            toast(text: state.model.message!, color: Colors.yellow);
          }
        }
      },
    );
  }
}
