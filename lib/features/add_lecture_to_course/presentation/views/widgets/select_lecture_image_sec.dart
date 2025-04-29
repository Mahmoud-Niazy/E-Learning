import 'dart:io';
import 'package:e_learning/core/widgets/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/widgets/custom_text_button.dart';
import '../../manager/add_new_lecture_cubit.dart';
import '../../manager/add_new_lecture_states.dart';

class AddLectureImageSec extends StatelessWidget {
  final bool isEdit;

  const AddLectureImageSec({
    super.key,
    required this.isEdit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNewLectureCubit, AddNewLectureStates>(
      builder: (context, state) {
        var cubit = AddNewLectureCubit.get(context);
        return Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black38,
              ),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  state is UploadLectureImageLoadingState
                      ? const CustomCircularProgressIndicator()
                      : Expanded(
                          child: Image.asset(
                            AppAssets.gallary,
                            height: 30,
                            width: 30,
                          ),
                        ),
                  Expanded(
                    flex: 3,
                    child: CustomTextButton(
                      title: 'select_lecture_image'.tr,
                      onPressed: () {
                        cubit.pickImage();
                      },
                    ),
                  ),
                ],
              ),
              if (cubit.pickedImage != null)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image.file(
                    File(cubit.pickedImage!.path),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
