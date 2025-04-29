import 'package:e_learning/core/utils/app_styles.dart';
import 'package:e_learning/core/widgets/empty_list_widget.dart';
import 'package:e_learning/features/favourites/presentation/manager/favourites_cubit.dart';
import 'package:e_learning/features/favourites/presentation/manager/favourites_states.dart';
import 'package:e_learning/features/home/data/models/get_courses_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../home/presentation/views/widgets/course_item.dart';

class FavouritesView extends StatelessWidget {
  const FavouritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.bookmark_border),
        title: Text(
          "favourites".tr,
          style: AppStyles.style17,
        ),
      ),
      body: BlocBuilder<FavouritesCubit, FavouritesState>(
        builder: (context, state) {
          var cubit = context.read<FavouritesCubit>();
          List<CourseResponseModel> allFavourites = cubit.favourites;
          if (allFavourites.isEmpty) {
            return EmptyListWidget();
          }
          return Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return CourseItem(course: allFavourites[index]);
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 15,
                );
              },
              itemCount: allFavourites.length,
            ),
          );
        },
      ),
    );
  }
}
