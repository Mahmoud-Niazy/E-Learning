import 'package:e_learning/core/methods/navigation.dart';
import 'package:e_learning/core/utils/app_dimensions.dart';
import 'package:e_learning/core/utils/app_styles.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/features/add_new_course/presentation/views/add_new_course_view.dart';
import 'package:e_learning/features/choose_language/presentation/views/choose_language_view.dart';
import 'package:e_learning/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:e_learning/features/home/presentation/manager/home_cubit/home_states.dart';
import 'package:e_learning/features/home/presentation/views/widgets/home_user_image.dart';
import 'package:e_learning/features/profile/presentation/views/widgets/setting_item.dart';
import 'package:e_learning/features/user_uploaded_courses/presentation/manager/uploaded_courses_cubit/user_uploaded_courses_cubit.dart';
import 'package:e_learning/features/user_uploaded_courses/presentation/views/user_uploaded_courses_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../add_new_course/presentation/manager/add_new_course_cubit.dart';
import '../../../edit_profile/presentation/views/edit_user_data_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: SingleChildScrollView(
            child: BlocBuilder<HomeCubit, HomeStates>(
              builder: (context, state) {
                var userData = context.read<HomeCubit>().user;
                return Stack(
                  children: [
                    Column(
                      children: [
                        Column(
                          children: [
                            HomeUserImage(
                              radius: AppDimensions.screenHeight * .05,
                            ),
                            SizedBox(
                              height: AppDimensions.screenHeight * .03,
                            ),
                            Text(
                              userData?.name ?? '',
                              style: AppStyles.style20,
                            ),
                            SizedBox(
                              height: AppDimensions.screenHeight * .01,
                            ),
                            Text(
                              userData?.email ?? '',
                              style: AppStyles.style13Grey,
                            ),
                            SizedBox(
                              height: AppDimensions.screenHeight * .01,
                            ),
                            Text(
                              userData?.phone ?? '',
                              style: AppStyles.style13Grey,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppDimensions.screenHeight * .05,
                        ),
                        SettingItem(
                          title: 'edit_your_profile'.tr,
                          onPressed: () {
                            navigate(context: context, screen: EditProfileView());
                          },
                        ),
                        SettingItem(
                          title: "be_an_instructor".tr,
                          onPressed: () {
                            navigate(
                              context: context,
                              screen: BlocProvider(
                                create: (context) =>
                                    serviceLocator<AddNewCourseCubit>(),
                                child: const AddNewCourseView(),
                              ),
                            );
                          },
                        ),
                        SettingItem(
                          title: 'your_uploaded_courses'.tr,
                          onPressed: () {
                            // if(context.read<UserUploadedCoursesCubit>().userUploadedCourses.isNotEmpty){
                              context.read<UserUploadedCoursesCubit>().getUserUploadedCourses();
                            // }
                            navigate(
                              context: context,
                              screen: const UserUploadedCoursesView(),
                            );
                          },
                        ),
                        SettingItem(
                          title: 'language'.tr,
                          onPressed: () {
                            navigate(context: context, screen: ChooseLanguageView());
                          },
                        ),
                        SettingItem(
                          title: 'mode'.tr,
                          onPressed: () {},
                        ),
                        SettingItem(
                          title: 'contact_us'.tr,
                          onPressed: () {},
                        ),
                        Padding(
                          padding: const EdgeInsets.all(40),
                          child: CustomButton(
                            backgroundColor: Colors.red.shade400,
                            title: 'sign_out'.tr,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    // if (state is GetUserDataLoadingState)
                    //   CustomCircularProgressIndicator(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
