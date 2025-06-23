import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/bloc/states.dart';
import '../models/category_model.dart';
import '../models/newsDataResponse.dart';
import '../models/sources_response.dart';
import '../ui/drawer_widget.dart';
import '../utils/constants.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit():super(HomeInitState()){}

  SourcesResponse? sourcesResponse;
  NewsDataResponse? newsDataResponse;
  int selectedTabIndex = 0;
  List<Sources> sources = [];

  static HomeCubit get(context)=>BlocProvider.of<HomeCubit>(context);

  Future<void>getSources(String categoryId) async{
    try{
      emit(SourcesLoadingState());
      //       protocol authority       //unencodedpath           //parameters
      Uri url=Uri.https(Constants.authority,"/v2/top-headlines/sources",{
        "apiKey":Constants.apiKey,
        "category": categoryId
      });

      //fetch data from api
      http.Response response= await http.get(url);

      // but data comes as string
      var data=response.body;

      // format to json it gives map
      var json=jsonDecode(data);

      // from json to model
      sourcesResponse=SourcesResponse.fromJson(json);

      sources = sourcesResponse?.sources ?? [];
      print("success");
      emit(SourcesSuccessState());
      getNews(sourcesResponse!.sources![selectedTabIndex].id??"");
    }
    catch(e){
      emit(SourcesErrorState());
      
    }
  }

  changeSource(int newSourceIndex){
    selectedTabIndex=newSourceIndex;
    emit(ChangeSource());
  }

   Future<void> getNews(String sourceID)async{
    try{
      emit(NewsLoadingState());
      Uri url=Uri.https(Constants.authority,"v2/everything",{
        "sources": sourceID,
         "apiKey": Constants.apiKey,

      });

      http.Response response=await http.get(url);
      if (response.statusCode!=200){
        emit(NewsErrorState());
        return;
      }
      var json=jsonDecode(response.body);
      newsDataResponse=NewsDataResponse.fromJson(json);
      emit(NewsSuccessState());
    }
    catch(e){
      emit(NewsErrorState());
    }
  }

  // when click on the category the categoryModel=categorySelected so go to home
  CategoryModel? categoryModel;
  onCategorySelect(category) {
    categoryModel = category;
    emit(CategorySelectState());
  }

  // if the categoryModel = null it will back to categories screen
  onDrawerSelect(id,BuildContext context){
    if(id== DrawerWidget.category_id)
    {
      categoryModel = null;
      Navigator.pop(context);
      emit(CategorySelectState());
    }else if(id==DrawerWidget.seting_id){

    }
  }

}