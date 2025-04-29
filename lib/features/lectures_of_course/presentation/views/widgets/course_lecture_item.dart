import 'package:e_learning/features/lecture_details/presentation/manager/lecture_details_cubit/lecture_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/methods/navigation.dart';
import '../../../../../core/utils/app_constance.dart';
import '../../../../../core/utils/app_dimensions.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/custom_icon_button.dart';
import '../../../../add_lecture_to_course/presentation/manager/add_new_lecture_cubit.dart';
import '../../../../add_lecture_to_course/presentation/views/add_new_lecture_view.dart';
import '../../../../home/data/models/get_courses_response_model.dart';
import '../../../../lecture_details/presentation/views/lecture_details_view.dart';
import '../../../data/models/lecture_response_model.dart';

class LectureItem extends StatelessWidget {
  final String courseId;
  final CourseInstructorResponse? instructor;
  final LectureResponseModel lecture;
  final int index;

  const LectureItem({
    super.key,
    required this.courseId,
    required this.instructor,
    required this.lecture,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    print(courseId);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black12,
            // color: AppConstance.primaryColor,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: AppDimensions.screenHeight * .05,
              width: AppDimensions.screenWidth * .1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppConstance.primaryColor,
              ),
              child: Text(
                '$index',
                textAlign: TextAlign.center,
                style: AppStyles.style20.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    lecture.title ?? '',
                    style: AppStyles.style13,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                   '${lecture.duration ?? 0}min',
                    style: AppStyles.style11.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            CustomIconButton(
              onPressed: () async {
                await context
                    .read<AddNewLectureCubit>()
                    .fillFieldsWithLectureData(lecture);
                navigate(
                    context: context,
                    screen: AddLectureView(
                      isEdit: true,
                      courseId: courseId,
                      lectureId: lecture.lectureId,
                    ));
              },
              icon: Icons.edit,
            ),
            CustomIconButton(
              onPressed: () {
                navigate(
                    context: context,
                    screen: LecturesDetailsView(
                      lecture: lecture,
                      instructor: instructor,
                    ));
                context.read<LectureDetailsCubit>().emptyNotesFields();
                context.read<LectureDetailsCubit>().getAllNotes(lecture.lectureId ?? '');
              },
              icon: Icons.play_circle,
            ),
          ],
        ),
      ),
    );
  }
}
