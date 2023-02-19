import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textCOntroller=TextEditingController();
    var formKey=GlobalKey<FormState>();
    var cubit =SearchCubit.get(context);
    return BlocConsumer<SearchCubit,SearchStates>(
        builder: (context,state){
         return Scaffold(
           body: SafeArea(
             child: Form(
               key: formKey,
               child: Padding(
                 padding: const EdgeInsets.only(left: 8.0,right:8.0,top: 20),
                 child: Column(
                   children: [

                     defaultTextFormField(controller: textCOntroller, validate: (value){
                       if(value==null ||value.isEmpty)
                         return "required text to search";
                     }, text: "Search", prefixIcon: Icons.search, keyboardType: TextInputType.text,
                     submit: (value){
                       if(formKey.currentState!.validate())
                         {
                           cubit.getSearchData(text: textCOntroller.text);
                         }
                     }
                     ),
                     SizedBox(height: 15,),
                     if(state is LoadingSearchState)
                       LinearProgressIndicator(),
                     if(cubit.searchModel !=null)
                       Expanded(
                         child: ListView.separated(
                             itemBuilder: (context,index)=>test(cubit.searchModel!.data!.data[index]), separatorBuilder: (context,index)=>SizedBox(height: 10,), itemCount: cubit.searchModel!.data!.data.length),
                       )
                   ],
                 ),
               ),
             ),
           ),
         );

        },
        listener: (context,state){}
    );
  }
}
