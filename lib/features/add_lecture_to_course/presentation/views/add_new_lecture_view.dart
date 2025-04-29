import 'package:e_learning/core/methods/navigation.dart';
import 'package:e_learning/core/methods/show_snack_bar.dart';
import 'package:e_learning/core/utils/app_constance.dart';
import 'package:e_learning/core/utils/app_styles.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/core/widgets/custom_circular_progress_indicator.dart';
import 'package:e_learning/core/widgets/custom_text_form_field.dart';
import 'package:e_learning/features/add_lecture_to_course/presentation/views/widgets/select_lecture_image_sec.dart';
import 'package:e_learning/features/add_lecture_to_course/presentation/views/widgets/select_lecture_video_sec.dart';
import 'package:e_learning/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:e_learning/features/layout/presentation/view/layout_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../core/cache_helper/cache_helper.dart';
import '../../../../core/methods/translate.dart';
import '../manager/add_new_lecture_cubit.dart';
import '../manager/add_new_lecture_states.dart';

class AddLectureView extends StatelessWidget {
  final bool isEdit;
  final String courseId;
  final String? lectureId;

  const AddLectureView({
    super.key,
    this.isEdit = false,
    required this.courseId,
    this.lectureId,
  });

  static var formKey = GlobalKey<FormState>();

  validate({
    required AddNewLectureCubit cubit,
    required BuildContext context,
  }) {
    if (formKey.currentState!.validate()) {
      if (cubit.pickedImage == null) {
        showSnackBar(
          context: context,
          label: 'image_required'.tr,
          color: Colors.red,
        );
        return;
      }
      if (cubit.pickedVideo == null) {
        showSnackBar(
          context: context,
          label: 'video_required'.tr,
          color: Colors.red,
        );
        return;
      }
      if(isEdit){
        updateLecture(cubit: cubit);
      }
      else{
        uploadLecture(
          cubit: cubit,
        );
      }
    }
  }

  Future<void> updateLecture({
    required AddNewLectureCubit cubit,
  })async{
    await cubit.updateLecture(courseId , lectureId ?? '');
  }

  Future<void> uploadLecture({
    required AddNewLectureCubit cubit,
  }) async {
    await cubit.addNewLecture(courseId);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var cubit = context.read<AddNewLectureCubit>();
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${"welcome".tr}, ',
                style: AppStyles.style20.copyWith(color: Colors.black),
              ),
              TextSpan(
                text: context.read<HomeCubit>().user!.name,
                style: AppStyles.style15Grey,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'lecture_title'.tr,
                    style: AppStyles.style17,
                  ),
                  SizedBox(
                    height: screenSize.height * .01,
                  ),
                  CustomTextFormField(
                    title: 'lecture_title'.tr,
                    controller: cubit.lectureTitleController,
                  ),
                  SizedBox(
                    height: screenSize.height * .02,
                  ),
                  Text(
                    'lecture_description'.tr,
                    style: AppStyles.style17,
                  ),
                  SizedBox(
                    height: screenSize.height * .01,
                  ),
                  CustomTextFormField(
                    maxLine: 7,
                    title: 'lecture_description'.tr,
                    keyboardType: TextInputType.multiline,
                    controller: cubit.lectureDescriptionController,
                  ),
                  SizedBox(
                    height: screenSize.height * .04,
                  ),
                  AddLectureImageSec(isEdit: isEdit),
                  SizedBox(
                    height: screenSize.height * .04,
                  ),
                  SelectLectureVideoSec(),
                  SizedBox(
                    height: screenSize.height * .04,
                  ),
                  BlocConsumer<AddNewLectureCubit, AddNewLectureStates>(
                    listener: (context, state) async {
                      if (state is AddNewLectureSuccessfullyState) {
                        showSnackBar(
                          context: context,
                          label: 'success'.tr,
                          color: AppConstance.primaryColor,
                        );
                        navigate(context: context, screen: LayoutView());
                      }
                      if (state is AddNewLectureErrorState) {
                        showSnackBar(
                          context: context,
                          label: CacheHelper.isAr != false
                              ? await translateEnglishToArabic(state.error)
                              : state.error,
                          color: Colors.red,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AddNewLectureLoadingState) {
                        return const CustomCircularProgressIndicator();
                      }
                      return CustomButton(
                        backgroundColor: AppConstance.primaryColor,
                        title: isEdit ? 'edit_lecture_data'.tr : 'add_lecture'.tr,
                        onPressed: () {
                          validate(
                            cubit: cubit,
                            context: context,
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: screenSize.height * .08,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
