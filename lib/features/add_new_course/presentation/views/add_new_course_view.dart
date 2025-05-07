import 'package:e_learning/core/methods/navigation.dart';
import 'package:e_learning/core/methods/show_snack_bar.dart';
import 'package:e_learning/core/utils/app_constance.dart';
import 'package:e_learning/core/utils/app_styles.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/core/widgets/custom_circular_progress_indicator.dart';
import 'package:e_learning/core/widgets/custom_text_form_field.dart';
import 'package:e_learning/features/add_new_course/presentation/manager/add_new_course_cubit.dart';
import 'package:e_learning/features/add_new_course/presentation/manager/add_new_course_states.dart';
import 'package:e_learning/features/add_new_course/presentation/views/widgets/select_course_image_sec.dart';
import 'package:e_learning/features/add_new_course/presentation/views/widgets/list_of_categories.dart';
import 'package:e_learning/features/add_new_course/presentation/views/widgets/select_course_video_sec.dart';
import 'package:e_learning/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:e_learning/features/layout/presentation/view/layout_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../core/cache_helper/cache_helper.dart';
import '../../../../core/methods/translate.dart';

class AddNewCourseView extends StatelessWidget {
  final bool isEdit;
  final String? courseId;

  const AddNewCourseView({
    super.key,
    this.isEdit = false,
    this.courseId
  });

  static var formKey = GlobalKey<FormState>();

  validate({
    required AddNewCourseCubit cubit,
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
        updateCourse(cubit: cubit);
      }
      else{
        uploadCourse(
          cubit: cubit,
        );
      }
    }
  }

  Future<void> updateCourse({
    required AddNewCourseCubit cubit,
  })async{
    await cubit.updateCourse(courseId!);
  }

  Future<void> uploadCourse({
    required AddNewCourseCubit cubit,
  }) async {
    await cubit.addNewCourse();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var cubit = context.read<AddNewCourseCubit>();
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${"welcome".tr}, ',
                style: AppStyles.style20.copyWith(
                  color: CacheHelper.isDarkMode ? Colors.white : Colors.black,
                ),
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
          padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'course_title'.tr,
                    style: AppStyles.style17,
                  ),
                  SizedBox(
                    height: screenSize.height * .01,
                  ),
                  CustomTextFormField(
                    title: 'course_title'.tr,
                    controller: cubit.courseTitleController,
                  ),
                  SizedBox(
                    height: screenSize.height * .02,
                  ),
                  Text(
                    'course_description'.tr,
                    style: AppStyles.style17,
                  ),
                  SizedBox(
                    height: screenSize.height * .01,
                  ),
                  CustomTextFormField(
                    maxLine: 7,
                    title: 'course_description'.tr,
                    keyboardType: TextInputType.multiline,
                    controller: cubit.courseDescriptionController,
                  ),
                  SizedBox(
                    height: screenSize.height * .02,
                  ),
                  Text(
                    'price'.tr,
                    style: AppStyles.style17,
                  ),
                  SizedBox(
                    height: screenSize.height * .01,
                  ),
                  CustomTextFormField(
                    title: 'price'.tr,
                    keyboardType: TextInputType.number,
                    controller: cubit.coursePriceController,
                    pIcon: Icons.attach_money_sharp,
                  ),
                  SizedBox(
                    height: screenSize.height * .03,
                  ),
                  Text(
                    'category'.tr,
                    style: AppStyles.style17,
                  ),
                  SizedBox(
                    height: screenSize.height * .015,
                  ),
                  const SizedBox(
                    height: 40,
                    child: ListOfCategories(),
                  ),
                  SizedBox(
                    height: screenSize.height * .04,
                  ),
                  AddCourseImageSec(isEdit: isEdit),
                  SizedBox(
                    height: screenSize.height * .04,
                  ),
                  SelectCourseVideoSec(),
                  SizedBox(
                    height: screenSize.height * .04,
                  ),
                  BlocConsumer<AddNewCourseCubit, AddNewCourseStates>(
                    listener: (context, state) async {
                      if (state is AddNewCourseSuccessfullyState) {
                        showSnackBar(
                          context: context,
                          label: 'success'.tr,
                          color: AppConstance.primaryColor,
                        );
                        navigate(context: context, screen: LayoutView());
                      }
                      if (state is AddNewCourseErrorState) {
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
                      if (state is AddNewCourseLoadingState) {
                        return const CustomCircularProgressIndicator();
                      }
                      return CustomButton(
                        backgroundColor: AppConstance.primaryColor,
                        title: isEdit ? 'edit_course_data'.tr : 'add_course'.tr,
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
