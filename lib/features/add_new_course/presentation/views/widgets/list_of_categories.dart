import 'package:e_learning/features/add_new_course/presentation/manager/add_new_course_cubit.dart';
import 'package:e_learning/features/add_new_course/presentation/manager/add_new_course_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../home/presentation/views/widgets/category_item.dart';

class ListOfCategories extends StatelessWidget {
  const ListOfCategories({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AddNewCourseCubit, AddNewCourseStates>(
      builder: (context, state) {
        var cubit = AddNewCourseCubit.get(context);
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                cubit.selectCategory(index);
              },
              child: CategoryItem(
                category: cubit.categories[index],
                isSelected: cubit.selectedCategory == index,
              ),
            );
          },
          separatorBuilder: (context, index) =>
          const SizedBox(
            width: 10,
          ),
          itemCount: cubit.categories.length,
        );
      },
    );
  }
}