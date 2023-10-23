// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:news_app/modules/business_screen.dart';
import 'package:news_app/modules/science_screen.dart';
import 'package:news_app/modules/setting_screen.dart';
import 'package:news_app/modules/sports_screen.dart';
import 'package:news_app/modules/support_me_screen.dart';
import 'package:news_app/shared/bloc/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';

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
    BottomNavigationBarItem(
      icon: Icon(Bootstrap.heart_fill),
      label: 'Thanks',
    ),
  ];

  List<Widget> screen = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingScreen(),
    SupportMeScreen(),
  ];

  // this for change bottomNav
  void changeBottomNavIndex(index) {
    currentIndex = index;
    if (index == 0) {
      getBusiness();
    } else if (index == 1) {
      getSport();
    } else if (index == 2) {
      getScience();
    }
    emit(NewsChangeBottomNavIndexState());
  }

  // ignore: non_constant_identifier_names
  static String API_KEY = '7a4a49d7b6284d2fa9da2f1e81e06663';

  List<dynamic> businessList = [];

  void getBusiness() {
    // if (businessList.length == 0) {
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
    // } else {
    // }
  }

  List<dynamic> sportList = [];

  void getSport() {
    // if (sportList.length == 0) {
      emit(NewsGetSportLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'sport',
          'apiKey': '$API_KEY',
        },
      ).then((value) {
        sportList = value?.data['articles'];
        emit(NewsGetSportSuccessState());
      }).catchError((error) {
        print('this is error ${error.toString()}');
        emit(NewsGetSportErrorState(error: error.toString()));
      });
    // } else {}
  }

  List<dynamic> scienceList = [];

  void getScience() {
    // if (scienceList.length == 0) {
      emit(NewsGetScienceLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'science',
          'apiKey': '$API_KEY',
        },
      ).then((value) {
        scienceList = value?.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print('this is error ${error.toString()}');
        emit(NewsGetScienceErrorState(error: error.toString()));
      });
    // } else {}
  }

  // for add dark mod
  var isDark = false;

  // this to convert to dark to light or reverse
  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeAppMode());
    } else {
      isDark = !isDark;
      // this for save in cache and save the mod
      CacheHelper.putData(key: 'isDark', value: isDark).then(
        (value) {
          emit(ChangeAppMode());
        },
      );
    }
  }

  List<dynamic> searchList = [];

  getSearch({required String? searchValue}) {
    emit(NewsGetSearchLoading());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        // 'country': 'us',
        'q': searchValue,
        'apiKey': '$API_KEY',
      },
    ).then((value) {
      searchList = value?.data['articles'];    
      emit(NewsGetSearchSuccess());
    }).catchError((error) {
      print('this is error ${error.toString()}');
      emit(NewsGetSearchError(error: error.toString()));
    });
  }
}
