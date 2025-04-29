import 'package:e_learning/core/utils/app_constance.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../data/models/language_item_model/language_item_model.dart';

//ignore: must_be_immutable
class LanguageItem extends StatelessWidget {
  final LanguageItemModel languageItemModel;
  final void Function() onPressed ;
  bool? isSelected ;
  
   LanguageItem({
    super.key,
    required this.languageItemModel,
    required this.onPressed,
    this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          border: Border.all(
            width: isSelected== true ? 3 : 2,
            color: isSelected == true ? AppConstance.primaryColor : Colors.black12,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  languageItemModel.flag,
                  height: 35,
                  width: 35,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  languageItemModel.languageEName,
                  style: AppStyles.style17,
                ),
              ],
            ),
            Text(
              languageItemModel.languageAName,
            ),
          ],
        ),
      ),
    );
  }
}
