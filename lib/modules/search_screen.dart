import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/bloc/cubit.dart';
import '../shared/bloc/states.dart';
import '../shared/components/widgets.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).searchList;
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: formFieldWidget(
                    controller: controller,
                    labelText: 'labelText',
                    validMsg: (String? value) {
                      if (value!.isEmpty) {
                        return 'Pleass ';
                      }
                      return null;
                    },
                    prefixIcon: Icon(Icons.search),
                    type: TextInputType.text,
                    onChanged: (String? change) {
                      NewsCubit.get(context).getSearch(searchValue: change);
                    },
                  ),
                ),
              Expanded(child: buildArticle(list: list , itemCount: 10 , isSearch: true,)),
              ],
            ),
          ),
        );
      },
    );
  }
}
