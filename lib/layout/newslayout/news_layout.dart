import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_applicatio/layout/newslayout/cubit/cubit.dart';
import 'package:news_applicatio/layout/newslayout/cubit/states.dart';
import 'package:news_applicatio/modules/search/search_screen.dart';
import 'package:news_applicatio/shared/components/components.dart';


class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'News App',
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: (){
                    navigateTo(context, SearchScreen(),);
                  },
                  ),
              IconButton(
                  icon: Icon(Icons.brightness_4_outlined,),
                  onPressed: (){
                    cubit.changeAppMode();
                  },
                  ),
            ],
          ),

          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomItems,
          ),
        );
      },

    );
  }
}
