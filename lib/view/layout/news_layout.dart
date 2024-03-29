import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/view/modules/search_screen.dart';
import 'package:news_app/controller/cubit.dart';
import 'package:news_app/shared/components/widgets.dart';

import '../../controller/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Atun News'),
            actions: [
              IconButton(
                onPressed: () {
                  navigateToScreen(screen: SearchScreen(), context: context);
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavIndex(index);
            },
            items: cubit.bottomItem,
          ),
        );
      },
    );
  }
}
