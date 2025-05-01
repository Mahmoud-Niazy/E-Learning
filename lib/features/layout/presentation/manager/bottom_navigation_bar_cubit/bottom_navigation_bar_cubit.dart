

import 'package:e_learning/features/chat/presentation/views/all_conversations_view.dart';
import 'package:e_learning/features/enrolled_courses/presentation/views/enrolled_courses_view.dart';
import 'package:e_learning/features/favourites/presentation/views/favourites_view.dart';
import 'package:e_learning/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../home/presentation/views/home_view.dart';
import '../../../../search/presentation/views/search_view.dart';
import 'bottom_navigation_bar_states.dart';

class BottomNavigationBarCubit extends Cubit<BottomNavigationBarStates> {
  BottomNavigationBarCubit()
      : super(
          BottomNavigationBarInitialState(),
        );

  static BottomNavigationBarCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    HomeView(),
    AllChatsView(),
    EnrolledCoursesView(),
    FavouritesView(),
    SearchView(),
    ProfileView(),
  ];
  int currentIndex = 0;

  toggle(int index){
    currentIndex = index;
    emit(BottomNavigationBarToggleState());
  }
}
