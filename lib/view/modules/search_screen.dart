import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/cubit.dart';
import '../../controller/states.dart';
import '../../shared/components/widgets.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: formFieldWidget(
                    controller: controller,
                    labelText: 'News Title',
                    prefixIcon: const Icon(Icons.search),
                    type: TextInputType.text,
                    onChanged: (String? change) {
                      NewsCubit.get(context).getSearch(searchValue: change);
                    },
                    context: context,
                  ),
                ),
                Expanded(
                  child: buildArticle(
                    list: NewsCubit.get(context).searchList,
                    itemCount: 10,
                    isSearch: true,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
