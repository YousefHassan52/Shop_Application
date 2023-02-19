import '../../models/change_favourite_model/change_favourite_model.dart';

abstract class AppStates{}
class AppInitialState extends AppStates{}
class AppChangeBottomNavBarState extends AppStates{}
class AppGetHomeDataSuccessffulState extends AppStates{}

class AppGetHomeDataErrorState extends AppStates{
  String error;

  AppGetHomeDataErrorState(this.error);
}
class AppGetHomeDataLoadingState extends AppStates{}


class AppGetCategorySuccessffulState extends AppStates{}
class AppGetCategoryErrorState extends AppStates{
  String error;

  AppGetCategoryErrorState(this.error);
}

class AppGetFavouritesSuccessffulState extends AppStates{}
class AppGetFavouritesLoadingState extends AppStates{}
class AppGetFavouritesErrorState extends AppStates{
  String error;

  AppGetFavouritesErrorState(this.error);
}

class AppGetProfileSuccessffulState extends AppStates{}
class AppGetProfileLoadingState extends AppStates{}
class AppGetProfileErrorState extends AppStates{
  String error;

  AppGetProfileErrorState(this.error);
}
class AppUpdateProfileSuccessffulState extends AppStates{}
class AppUpdateProfileLoadingState extends AppStates{}
class AppUpdateProfileErrorState extends AppStates{
  String error;

  AppUpdateProfileErrorState(this.error);
}

class AppChangeFavouritesState extends AppStates{}
class AppChangeFavouritesSuccessState extends AppStates{
  ChangeFavouriteModel model;
  AppChangeFavouritesSuccessState(this.model);
}
class AppChangeFavouritesErrorState extends AppStates{}

class AppSignoutLoadingState extends AppStates{}
class AppSignoutSuccessState extends AppStates{}
class AppSignoutErrorState extends AppStates{
  final String error;

  AppSignoutErrorState(this.error);
}
