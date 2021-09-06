import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_applicatio/layout/newslayout/cubit/states.dart';
import 'package:news_applicatio/modules/Business/business_screen.dart';
import 'package:news_applicatio/modules/science/science_screen.dart';
import 'package:news_applicatio/modules/sports/sports_screen.dart';
import 'package:news_applicatio/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit <NewsStates>{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context)  => BlocProvider.of(context);

  int currentIndex =0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
      Icons.business,
    ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
      Icons.sports,
    ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science_outlined,
      ),
      label: 'Science',
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  void changeBottomNavBar (int index){
    currentIndex = index;
    if(index == 1)
      getSports();
    if(index == 2)
      getScience();
    emit(NewsBottomNavState());
  }
  
  List<dynamic> business = [];

  void getBusiness(){
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'business',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
      },).then((value) {
      //print(value.data['articles'][0]['tittle']);
      business = value.data['articles'];
      print(business[0]['title']);
      
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports(){
    emit(NewsGetSportsLoadingState());

    if (sports.length == 0){
      DioHelper.getData(url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
        },).then((value) {
        //print(value.data['articles'][0]['tittle']);
        sports = value.data['articles'];
        print(sports[0]['title']);

        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }
    else{
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience(){
    emit(NewsGetScienceLoadingState());
    if(science.length == 0){
      DioHelper.getData(url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
        },).then((value) {
        //print(value.data['articles'][0]['tittle']);
        science = value.data['articles'];
        print(science[0]['title']);

        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }
  }

  bool isDark= true;

  void changeAppMode(){
    isDark = !isDark;
    emit(AppChangeModeState());
  }
}
