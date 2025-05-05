import 'package:e_learning/core/methods/navigation.dart';
import 'package:e_learning/core/methods/show_date_picker.dart';
import 'package:e_learning/core/methods/show_snack_bar.dart';
import 'package:e_learning/core/utils/app_constance.dart';
import 'package:e_learning/core/utils/app_dimensions.dart';
import 'package:e_learning/core/utils/app_styles.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/core/widgets/custom_circular_progress_indicator.dart';
import 'package:e_learning/core/widgets/custom_icon_button.dart';
import 'package:e_learning/core/widgets/custom_text_button.dart';
import 'package:e_learning/core/widgets/custom_text_form_field.dart';
import 'package:e_learning/features/create_coupon/presentation/manager/create_coupon_cubit/create_coupon_cubit.dart';
import 'package:e_learning/features/create_coupon/presentation/manager/create_coupon_cubit/create_coupon_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/cache_helper/cache_helper.dart';
import '../../../../core/methods/translate.dart';

class CreateCouponView extends StatelessWidget {
  final String courseId;
  static var formKey = GlobalKey<FormState>();

  const CreateCouponView({
    super.key,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    var screenHeight = AppDimensions.screenHeight;
    return Scaffold(
      appBar: AppBar(
        title: Text('create_coupon'.tr),
      ),
      body: BlocConsumer<CreateCouponCubit, CreateCouponStates>(
        listener: (context, state)async {
          if (state is CreateCouponSuccessState) {
            showSnackBar(
              context: context,
              label: 'success'.tr,
              color: AppConstance.primaryColor,
            );
            navigatePop(context: context);
          }
          if (state is CreateCouponErrorState) {
            showSnackBar(
              context: context,
              label: CacheHelper.isAr != false ? await translateEnglishToArabic(state.error) : state.error,
              color: AppConstance.warningColor,
            );
          }
        },
        builder: (context, state) {
          var cubit = context.read<CreateCouponCubit>();
          return SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 28
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'discount_percent'.tr,
                            style: AppStyles.style13,
                          ),
                          SizedBox(
                            height: screenHeight * .02,
                          ),
                          CustomTextFormField(
                            keyboardType: TextInputType.number,
                            title: 'discount_percent'.tr,
                            controller: cubit.discountPercentController,
                          ),
                          SizedBox(
                            height: screenHeight * .01,
                          ),
                          Text(
                            'discount_example'.tr,
                            style: AppStyles.style13Grey,
                          ),
                          SizedBox(
                            height: screenHeight * .03,
                          ),
                          Text(
                            'student_number_limit'.tr,
                            style: AppStyles.style13,
                          ),
                          SizedBox(
                            height: screenHeight * .02,
                          ),
                          Row(
                            children: [
                              CustomIconButton(
                                onPressed: () {
                                  cubit.increaseStudentLimitNumber();
                                },
                                icon: Icons.add,
                              ),
                              CustomIconButton(
                                onPressed: () {
                                  cubit.decreaseStudentLimitNumber();
                                },
                                icon: Icons.remove,
                              ),
                              Expanded(
                                child: CustomTextFormField(
                                  title: 'student_number_limit'.tr,
                                  keyboardType: TextInputType.number,
                                  controller: cubit.studentLimitController,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: screenHeight * .01,
                          ),
                          Text(
                            'student_limit_example'.tr,
                            style: AppStyles.style13Grey,
                          ),
                          SizedBox(
                            height: screenHeight * .03,
                          ),
                          Text(
                            'coupon_code'.tr,
                            style: AppStyles.style13,
                          ),
                          SizedBox(
                            height: screenHeight * .02,
                          ),
                          CustomTextFormField(
                            maxLine: 5,
                            title: 'coupon_code'.tr,
                            controller: cubit.couponController,
                          ),
                          CustomTextButton(
                            title: 'auto_generate_code'.tr,
                            onPressed: () {
                              cubit.autoGenerateCouponCode(courseId);
                            },
                          ),
                          SizedBox(
                            height: screenHeight * .01,
                          ),
                          Text(
                            'expiry_date'.tr,
                            style: AppStyles.style13,
                          ),
                          SizedBox(
                            height: screenHeight * .02,
                          ),
                          CustomTextFormField(
                            title: 'expiry_date'.tr,
                            controller: cubit.expiryDateController,
                            pIcon: Icons.date_range,
                            onPressOnPrefixIcon: () async {
                              DateTime? dateTime =
                                  await showDatePickerDialog(context);
                              if (dateTime != null) {
                                cubit.expiryDateController.text =
                                    dateTime.toString().split(' ').first;
                              }
                            },
                            pIconColor: AppConstance.primaryColor,
                          ),
                          SizedBox(
                            height: screenHeight * .02,
                          ),
                          CustomButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.createCoupon(courseId);
                              }
                            },
                            title: 'confirm'.tr,
                            backgroundColor: AppConstance.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (state is CreateCouponLoadingState)
                  CustomCircularProgressIndicator(),
              ],
            ),
          );
        },
      ),
    );
  }
}
