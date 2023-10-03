// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/shared/components/widgets.dart';

import '../shared/bloc/cubit.dart';
import '../shared/bloc/states.dart';

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
        var cubit = NewsCubit.get(context);
        return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                    color: Color(0xFFE3E3E3).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10)),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
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
                      Row(
                        children: [
                          Text('News Country'),
                          Spacer(),
                          // DropdownButtonHideUnderline(
                          //   child: DropdownButton2<String>(
                          //     isExpanded: true,
                          //     hint: Text(
                          //       'Select Item',
                          //       style: TextStyle(
                          //         fontSize: 14,
                          //         color: Theme.of(context).hintColor,
                          //       ),
                          //     ),
                          //     items: cubit.items
                          //         .map(
                          //             (String item) => DropdownMenuItem<String>(
                          //                   value: item,
                          //                   child: Text(
                          //                     item,
                          //                     style: const TextStyle(
                          //                       fontSize: 14,
                          //                     ),
                          //                   ),
                          //                 ))
                          //         .toList(),
                          //     value: cubit.newsOfCountyValue,
                          //     onChanged: (String? value) {
                          //       // setState(() {
                          //       //   selectedValue = value;
                          //       // });
                          //       cubit.changedCountryDrop(change: value);
                          //     },
                          //     buttonStyleData: const ButtonStyleData(
                          //       padding: EdgeInsets.symmetric(horizontal: 16),
                          //       height: 40,
                          //       width: 140,
                          //     ),
                          //     menuItemStyleData: const MenuItemStyleData(
                          //       height: 40,
                          //     ),
                          //   ),
                          // ),
                          DropListWidget(
                            items: cubit.items
                                .map(
                                  (String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            value: cubit.newsOfCountyValue,
                            onChange: (String? value) {
                              cubit.changedCountryDrop(change: value);
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
