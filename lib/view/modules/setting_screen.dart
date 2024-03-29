// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/shared/components/widgets.dart';

import '../../controller/cubit.dart';
import '../../controller/states.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.all(15.0.sp),
              child: Container(
                height: 250.sp,
                decoration: BoxDecoration(
                    color: Color(0xFFE3E3E3).withOpacity(0.5.sp),
                    borderRadius: BorderRadius.circular(10.sp)),
                width: double.infinity,
                child: Padding(
                    padding:  EdgeInsets.all(15.0.sp),
                    child: Column(
                      children: [
                        Text('BETA'),
                        Row(
                          children: [
                            Text('Dark Or Light Mod'),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.brightness_4),
                              style: Theme.of(context).iconButtonTheme.style,
                              onPressed: () {
                                NewsCubit.get(context).changeAppMode();
                              },
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
          ),
        );
      },
    );
  }
}
