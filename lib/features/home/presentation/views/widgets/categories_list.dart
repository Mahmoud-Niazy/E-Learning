import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_dimensions.dart';
import '../../manager/home_cubit/home_cubit.dart';
import 'category_item.dart';

class CategoriesList extends StatelessWidget{
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit =  context.read<HomeCubit>();
    return SizedBox(
      height: AppDimensions.screenHeight * .05,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              cubit.selectCategory(index);
            },
            child: CategoryItem(
              category: cubit.categories[index],
              isSelected: index == cubit.selectedCategory,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 15,
          );
        },
        itemCount: cubit.categories.length,
      ),
    );
  }
}