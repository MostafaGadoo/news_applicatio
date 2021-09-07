import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_applicatio/layout/newslayout/cubit/cubit.dart';
import 'package:news_applicatio/layout/newslayout/cubit/states.dart';
import 'package:news_applicatio/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        var list = cubit.search;
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(
                  Icons.brightness_4_outlined,
                ),
                onPressed: () {
                  cubit.changeAppMode();
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  onChanged: (value) {
                    cubit.getSearch(value);
                  },
                  label: 'Search'.toUpperCase(),
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'search must not be empty';
                    } else {
                      return null;
                    }
                  },
                  controller: searchController,
                  type: TextInputType.text,
                  prefix: Icons.search_outlined,
                ),
              ),
              Expanded(
                child: articleBuilder(list, context),
              ),
            ],
          ),
        );
      },
    );
  }
}
