import 'package:shop_app/models/search_model/search_model.dart';

abstract class SearchStates{

}
class InitialSearchState extends SearchStates{

}
class SuccessSearchState extends SearchStates{

}
class LoadingSearchState extends SearchStates{

}

class ErrorSearchState extends SearchStates{
  final String error;

  ErrorSearchState(this.error);
}
