import 'package:e_learning/core/utils/app_constance.dart';
import 'package:e_learning/features/home/data/models/category_model.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/app_styles.dart';

//ignore: must_be_immutable
class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  bool isSelected ;

  CategoryItem({
    super.key,
    required this.category,
     this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color:  isSelected ? Colors.white : Colors.black38,
        ),
        color: isSelected ? AppConstance.primaryColor : Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            category.image,
            height: 35,
            width: 35,
          ),

          const SizedBox(
            width: 15,
          ),
          Text(
            category.name,
            style: AppStyles.style13.copyWith(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),

        ],
      ),
    );
  }
}
