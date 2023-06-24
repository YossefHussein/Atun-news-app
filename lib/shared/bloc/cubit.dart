// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business_screen.dart';
import 'package:news_app/modules/science_screen.dart';
import 'package:news_app/modules/setting_screen.dart';
import 'package:news_app/modules/sports_screen.dart';
import 'package:news_app/shared/bloc/states.dart';

import '../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(BuildContext context) => BlocProvider.of(context);

  // current screen
  int currentIndex = 0;

  // this bottomNav
  List<BottomNavigationBarItem> bottomItem = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  List<Widget> screen = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingScreen(),
  ];

  // this for change bottomNav
  void changeBottomNavIndex(index) {
    currentIndex = index;
    emit(NewsChangeBottomNavIndexState());
  }

  List<dynamic> businessList = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'category': 'business',
        'apiKey': '9fe457e3fc88401982e1ecf575b469bf',
      },
    ).then((value) {
      // print(value.data['articles'][0]['title']);
      businessList = value?.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print('this is error ${error.toString()}');
      emit(NewsGetBusinessErrorState(error: error.toString()));
    });
  }

  List<dynamic> sportList = [];

  void getSport() {
    emit(NewsGetSportLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'category': 'sport',
        'apiKey': '9fe457e3fc88401982e1ecf575b469bf',
      },
    ).then((value) {
      sportList = value?.data['articles'];
      emit(NewsGetSportSuccessState());
    }).catchError((error) {
      print('this is error ${error.toString()}');
      emit(NewsGetSportErrorState(error: error.toString()));
    });
  }

  List<dynamic> scienceList = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'category': 'science',
        'apiKey': '9fe457e3fc88401982e1ecf575b469bf',
      },
    ).then((value) {
      scienceList = value?.data['articles'];
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      print('this is error ${error.toString()}');
      emit(NewsGetScienceErrorState(error: error.toString()));
    });
  }
}
