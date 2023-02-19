import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/category_model/category_model.dart';
import 'package:shop_app/models/change_favourite_model/change_favourite_model.dart';
import 'package:shop_app/models/favourite_model/favourite_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favourites/favourites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

import '../../models/login_model/login_model.dart';
import '../../modules/login/login.dart';
import '../components/components.dart';
import '../components/constants.dart';
import '../network/local/cash_helper.dart';
import '../styles/colors.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit():super(AppInitialState());
  static AppCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;

  void changeBottomNav(index){
    currentIndex=index;
    emit(AppChangeBottomNavBarState());
  }

  List <Widget> screens=[
    const ProductsScreen(),
    CategoriesScreen(),
     FavouritesScreen(),
     SettingsScreen(),
  ];

  List<BottomNavigationBarItem> navBarItems=[
    const BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
    const BottomNavigationBarItem(icon: Icon(Icons.grid_view),label: "Categories"),
    const BottomNavigationBarItem(icon: Icon(Icons.favorite_outlined),label: "Favourites"),
    const BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Settings"),

  ];
  
  HomeModel? homeModel;
  Map<int,bool> favouritesMap={}; // feha kol el products id we gamb kol id bool 2za kan favourites walla la
  void getHomeData(){
    emit(AppGetHomeDataLoadingState());
    DioHelper.getData(url: HOME,token: token!,lang: "en" ) // el token hayb2a m3aya 2slan 2bl ma 2bda2 el app
        .then((value) {
      homeModel=HomeModel.fromJson(value.data);
     // print(homeModel!.data!.products[0].name);
      for (var element in homeModel!.data!.products) {
        favouritesMap.addAll({
          element.id:element.inFavorites,
        });
      }
      print(favouritesMap);


      emit(AppGetHomeDataSuccessffulState());
    }).catchError((error){
      print(error.toString());
      emit(AppGetHomeDataErrorState(error.toString()));
    });
    
  }

  CategoriesModel? categoryModel;
  void getCategory(){
    DioHelper.getData(url: GET_CATEGORY, lang: "en") // el token hayb2a m3aya 2slan 2bl ma 2bda2 el app
        .then((value) {
      categoryModel=CategoriesModel.fromJson(value.data);
      print(categoryModel!.data!.dataModel[0].name);

      emit(AppGetCategorySuccessffulState());
    }).catchError((error){
      print(error.toString());
      emit(AppGetCategoryErrorState(error.toString()));
    });

  }
   ChangeFavouriteModel? changeFavouriteModel;
  void changeFavourites({required int productId}){
    favouritesMap[productId]=!favouritesMap[productId]!;
    emit(AppChangeFavouritesState());



    DioHelper.postData(
        url: FAVOURITES,
        data:
        {
          "product_id":productId,
        },
      token: token,
        // token: token,
    ).then((value) {
       changeFavouriteModel=ChangeFavouriteModel.fromJson(value.data);
      if(changeFavouriteModel!.status==false)
        {
          favouritesMap[productId]=!favouritesMap[productId]!;
        }
      else
        {
          getFavourite();
        }
      emit(AppChangeFavouritesSuccessState(changeFavouriteModel!));
    }).catchError((error){
      favouritesMap[productId]=!favouritesMap[productId]!;

      emit(AppChangeFavouritesErrorState());
    });
  }



  FavoritesModel? favouriteModel;
  void getFavourite(){
    emit(AppGetFavouritesLoadingState());
    DioHelper.getData(url: FAVOURITES, lang: "en",token: token!
    ) // el token hayb2a m3aya 2slan 2bl ma 2bda2 el app
        .then((value) {
      favouriteModel=FavoritesModel.fromJson(value.data);
      print("تمام ياض يا جووووووووو");
      print(favouriteModel!.data!.data[0].product!.name);


      emit(AppGetFavouritesSuccessffulState());
    }).catchError((error){
      print(error.toString());
      emit(AppGetFavouritesErrorState(error.toString()));
    });

  }

  LoginModel? userData;
  void getUserData(){
    emit(AppGetProfileLoadingState());
    DioHelper.getData(url: PROFILE, lang: "en",token: token!
    ) // el token hayb2a m3aya 2slan 2bl ma 2bda2 el app
        .then((value) {
      userData=LoginModel.fromJson(value.data);
      print(userData!.data!.name);


      emit(AppGetProfileSuccessffulState());
    }).catchError((error){
      print(error.toString());
      emit(AppGetProfileErrorState(error.toString()));
    });

  }

  void updateUserData({
  required String name,
  required String email,
  required String phone,
  }){
    emit(AppUpdateProfileLoadingState());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        lang: "en",token: token!,
        data: {
          "name":name,
          "email":email,
          "phone":phone,
        }
    ) // el token hayb2a m3aya 2slan 2bl ma 2bda2 el app
        .then((value) {
      userData=LoginModel.fromJson(value.data);
      print(userData!.data!.name);
      getAllScreensDataAfterSigninOrRegister();



      emit(AppUpdateProfileSuccessffulState());
    }).catchError((error){
      print(error.toString());
      emit(AppUpdateProfileErrorState(error.toString()));
    });

  }

  void signOut(context) {
    emit(AppSignoutLoadingState());
    CacheHelper.removeData(key: "token").then((value) {
      token=null;
      makeAllModelsNull();
      navigateToAndReplace(context, LoginScreen());
      toast(text: "come back again broo <3", color: mainColor);
      emit(AppSignoutSuccessState());
    }).catchError((onError){
      emit(AppSignoutErrorState(onError.toString()));
    });
  }

  void makeAllModelsNull() {
    favouriteModel=null;
    userData=null;
    homeModel=null;
    categoryModel=null;
  }

  void getAllScreensDataAfterSigninOrRegister(){
    getFavourite();
    getUserData();
    getHomeData();
    getCategory();
  }


}