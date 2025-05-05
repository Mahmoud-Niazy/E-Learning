import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../home/data/models/get_courses_response_model.dart';
import '../../../data/models/lecture_response_model.dart';
import '../../manager/course_lectures_cubit/course_lectures_cubit.dart';
import 'course_lecture_item.dart';

class LecturesList extends StatelessWidget {
  final String courseId;
  final CourseInstructorResponse? instructor;
  final bool isViewedByInstructor ;

  const LecturesList({
    super.key,
    required this.instructor,
    required this.courseId,
    required this.isViewedByInstructor,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CourseLecturesCubit>();
    return ListView.separated(
      itemBuilder: (context, index) {
        LectureResponseModel lecture = cubit.courseLectures[index];
        return LectureItem(
          courseId: courseId,
          index: index + 1,
          instructor: instructor,
          lecture: lecture,
          isViewedByInstructor: isViewedByInstructor,
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 15,
        );
      },
      itemCount: cubit.courseLectures.length,
    );
  }
}
