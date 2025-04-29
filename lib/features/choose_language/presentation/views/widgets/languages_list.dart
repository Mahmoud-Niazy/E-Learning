import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/localization/controller/localization_controller.dart';
import 'language_item.dart';

class LanguagesList extends StatelessWidget{
   LanguagesList({super.key});

  final LocalizationController controller = Get.put(LocalizationController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
      builder: (controller){
        return ListView.separated(
          itemBuilder: (context, index) {
            return LanguageItem(
              isSelected: controller.currentIndex == index,
              languageItemModel: controller.languages[index],
              onPressed: () {
                controller.changeLang(controller.languages[index].languageCode);
              },
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 15,
            );
          },
          itemCount: controller.languages.length,
        );
      },
    );
  }
}