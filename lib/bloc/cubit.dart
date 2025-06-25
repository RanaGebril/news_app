import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/bloc/states.dart';
import 'package:news_app/repo/home_repo.dart';
import '../models/NewsDataResponse.dart' show NewsDataResponse;
import '../models/category_model.dart';

import '../models/sourcesResponse.dart';
import '../ui/drawer_widget.dart';
import '../utils/constants.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeRepo homeRepo;
  HomeCubit(this.homeRepo):super(HomeInitState()){}

  SourcesResponse? sourcesResponse;
  NewsDataResponse? newsDataResponse;
  int selectedTabIndex = 0;
  List<Sources> sources = [];

  static HomeCubit get(context)=>BlocProvider.of<HomeCubit>(context);

  Future<void>getSources(String categoryId) async{
    try{
      emit(SourcesLoadingState());
      sourcesResponse = await homeRepo.getSources(categoryId);
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
      newsDataResponse = await homeRepo.getNews(sourceID);
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