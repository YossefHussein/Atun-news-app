import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/shared/bloc/bloc_observer.dart';
import 'package:news_app/shared/bloc/cubit.dart';
import 'package:news_app/shared/bloc/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:news_app/shared/styles/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.inti();
  var isDark = await CacheHelper.getData(key: 'isDark');
  runApp(MyApp(
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  bool? isDark = true;

  MyApp({
    Key? key,
    this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..changeAppMode(fromShared: isDark)
        ..getBusiness(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ScreenUtilInit(
            minTextAdapt: true,
            splitScreenMode: true,
            designSize: const Size(360, 690),
            builder: (BuildContext context, Widget? child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              // for change app theme
              themeMode: NewsCubit.get(context).isDark
                  ? ThemeMode.light
                  : ThemeMode.dark,
              title: 'News App API',
              theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarBrightness: Brightness.dark,
                  ),
                  color: Colors.white,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  elevation: 0.0,
                ),
                textTheme: const TextTheme(
                  labelLarge: TextStyle(
                    color: Colors.black,
                  ),
                  bodyMedium: TextStyle(
                    color: Colors.black,
                  ),
                  bodySmall: TextStyle(
                    color: Colors.black,
                  ),
                ),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  selectedItemColor: Colors.deepOrange,
                ),
                iconTheme: const IconThemeData(
                  color: Colors.black,
                ),
              ),
              darkTheme: ThemeData(
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: pColor,
                textTheme: const TextTheme(
                  labelLarge: TextStyle(
                    color: Colors.white,
                  ),
                  bodyMedium: TextStyle(
                    color: Colors.white,
                  ),
                  bodySmall: TextStyle(
                    color: Colors.white,
                  ),
                ),
                appBarTheme: AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: pColor,
                    statusBarBrightness: Brightness.dark,
                  ),
                  color: pColor,
                  titleTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: const IconThemeData(
                    color: Colors.white,
                  ),
                  elevation: 0.0,
                ),
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: pColor,
                  unselectedItemColor: Colors.grey,
                  selectedItemColor: Colors.deepOrange,
                ),
              ),
              home: const NewsLayout(),
            ),
          );
        },
      ),
    );
  }
}
