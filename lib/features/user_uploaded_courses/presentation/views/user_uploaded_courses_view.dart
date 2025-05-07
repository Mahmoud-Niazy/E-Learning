import 'package:e_learning/core/utils/app_styles.dart';
import 'package:e_learning/core/widgets/custom_circular_progress_indicator.dart';
import 'package:e_learning/core/widgets/custom_divider.dart';
import 'package:e_learning/core/widgets/empty_list_widget.dart';
import 'package:e_learning/features/add_new_course/presentation/manager/add_new_course_cubit.dart';
import 'package:e_learning/features/add_new_course/presentation/manager/add_new_course_states.dart';
import 'package:e_learning/features/user_uploaded_courses/presentation/manager/uploaded_courses_cubit/user_uploaded_courses_cubit.dart';
import 'package:e_learning/features/user_uploaded_courses/presentation/manager/uploaded_courses_cubit/user_uploaded_courses_state.dart';
import 'package:e_learning/features/user_uploaded_courses/presentation/views/widgets/uploaded_course_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class UserUploadedCoursesView extends StatelessWidget {
  const UserUploadedCoursesView({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<UserUploadedCoursesCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "your_uploaded_courses".tr,
          style: AppStyles.style17,
        ),
      ),
      body: BlocBuilder<UserUploadedCoursesCubit, UserUploadedCoursesStates>(
        builder: (context, state) {
          if (state is GetUserUploadedCoursesLoadingState) {
            return const CustomCircularProgressIndicator();
          }
          if (cubit.userUploadedCourses.isEmpty) {
            return EmptyListWidget();
          }
          return Padding(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<AddNewCourseCubit, AddNewCourseStates>(
              builder: (context, state) {
                return Stack(
                  children: [
                    ListView.separated(
                      itemBuilder: (context, index) {
                        return UploadedCourseItem(
                          course: cubit.userUploadedCourses[index],
                          onPressed: () {

                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return CustomDivider();
                      },
                      itemCount: cubit.userUploadedCourses.length,
                    ),
                    if(state is PrepareCourseDataLoadingState)
                      CustomCircularProgressIndicator(),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
