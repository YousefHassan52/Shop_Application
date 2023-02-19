import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/modules/onboarding/onboarding_screen.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/observer.dart';
import 'package:shop_app/shared/styles/styles.dart';

import 'modules/search/cubit/cubit.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();

  DioHelper.init();
  await CacheHelper.init();

  bool? finishBoarding=CacheHelper.getData("finishBoarding");
  token=CacheHelper.getData("token")??"";
  print("token: $token");
  Widget widget;// ma heya lw null ma3na kda 2n el finishBoarding = false ya sadeki (;

  if(finishBoarding!=null)
  {
    if(token !=null)
    {
      widget= ShopLayout();
    }
    else {
      widget= LoginScreen();
    }
  }
  else {
    widget= OnboardingScreen();
  }

  finishBoarding==null?print("null ya sa7by") :print("finishBoarding: $finishBoarding");

  runApp( MyApp(widget));
}

class MyApp extends StatelessWidget {
//  bool finishBoarding;
Widget widget;
  MyApp(this.widget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AppCubit()..getHomeData()..getCategory()..getFavourite()..getUserData()),
        BlocProvider(create: (context)=>LoginCubit()),
        BlocProvider(create: (context)=>SearchCubit()),
        BlocProvider(create: (context)=>RegisterCubit()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:widget,
        theme: lightTheme,
      ),
    );
  }
}
