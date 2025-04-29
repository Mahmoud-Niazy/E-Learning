import 'package:e_learning/core/widgets/custom_circular_progress_indicator.dart';
import 'package:e_learning/core/widgets/empty_list_widget.dart';
import 'package:e_learning/features/add_lecture_to_course/presentation/manager/add_new_lecture_cubit.dart';
import 'package:e_learning/features/lectures_of_course/presentation/manager/course_lectures_cubit/course_lectures_cubit.dart';
import 'package:e_learning/features/lectures_of_course/presentation/manager/course_lectures_cubit/course_lectures_states.dart';
import 'package:e_learning/features/lectures_of_course/presentation/views/widgets/course_lectures_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../add_lecture_to_course/presentation/manager/add_new_lecture_states.dart';
import '../../../home/data/models/get_courses_response_model.dart';

class CourseLecturesView extends StatelessWidget {
  final String courseId;
  final CourseInstructorResponse? instructor;

  const CourseLecturesView({
    super.key,
    required this.courseId,
    required this.instructor,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CourseLecturesCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'lectures'.tr,
        ),
      ),
      body: BlocBuilder<CourseLecturesCubit, CourseLecturesStates>(
        builder: (context, state) {
          if (state is GetCourseLecturesLoadingState) {
            return CustomCircularProgressIndicator();
          }
          if (cubit.courseLectures.isEmpty) {
            return EmptyListWidget();
          }
          return BlocBuilder<AddNewLectureCubit, AddNewLectureStates>(
            builder: (context, state) {
              return Stack(
                children: [
                  LecturesList(
                    instructor: instructor,
                    courseId: courseId,
                  ),
                  if (state is PrepareLectureDataLoadingState)
                    CustomCircularProgressIndicator(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
