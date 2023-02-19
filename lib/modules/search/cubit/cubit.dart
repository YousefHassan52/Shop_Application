import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

import '../../../shared/components/constants.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(InitialSearchState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void getSearchData({
    required String text,
  }) {
    emit(LoadingSearchState());
    DioHelper.postData(
      url: SEARCH,
      data: {
      "text": text,
    },
      token: token,
    ).then((value) {
      searchModel=SearchModel.fromJson(value.data);
      emit(SuccessSearchState());
    }).catchError((error){
      emit(ErrorSearchState(error.toString()));
    });
  }
}
