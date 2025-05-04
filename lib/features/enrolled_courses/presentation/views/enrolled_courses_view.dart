import 'package:e_learning/core/methods/navigation.dart';
import 'package:e_learning/core/widgets/custom_circular_progress_indicator.dart';
import 'package:e_learning/core/widgets/empty_list_widget.dart';
import 'package:e_learning/features/enrolled_courses/presentation/manager/enrolled_courses_cubit/enrolled_courses_cubit.dart';
import 'package:e_learning/features/enrolled_courses/presentation/manager/enrolled_courses_cubit/enrolled_courses_state.dart';
import 'package:e_learning/features/home/presentation/views/widgets/course_item.dart';
import 'package:e_learning/features/lectures_of_course/presentation/views/course_lectures_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../lectures_of_course/presentation/manager/course_lectures_cubit/course_lectures_cubit.dart';

class EnrolledCoursesView extends StatelessWidget {
  const EnrolledCoursesView({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<EnrolledCoursesCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "enrolled_courses".tr,
          style: AppStyles.style17,
        ),
      ),
      body: BlocBuilder<EnrolledCoursesCubit, EnrolledCoursesStates>(
        builder: (context, state) {
          if (state is GetEnrolledCoursesLoadingState) {
            return CustomCircularProgressIndicator();
          }
          if (cubit.enrolledCourses.isEmpty) {
            return EmptyListWidget();
          }
          return ListView.separated(
            itemBuilder: (context, index) {
              var course = cubit.enrolledCourses[index];
              return CourseItem(
                course: course,
                onPressed: () async{
                  navigate(
                      context: context,
                      screen: CourseLecturesView(
                        courseId: course.id ?? '',
                        instructor: course.instructorDetails,
                      ),
                  );
                  await context
                      .read<CourseLecturesCubit>()
                      .getCourseLectures(course.id ?? '');
                },
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 15,
              );
            },
            itemCount: cubit.enrolledCourses.length,
          );
        },
      ),
    );
  }
}
