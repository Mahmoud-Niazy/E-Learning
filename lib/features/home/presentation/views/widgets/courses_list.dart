import 'package:e_learning/core/widgets/empty_list_widget.dart';
import 'package:e_learning/features/course_details/presentation/manager/course_details_cubit/course_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/methods/navigation.dart';
import '../../../../course_details/presentation/views/course_details_view.dart';
import '../../../data/models/get_courses_response_model.dart';
import '../../manager/home_cubit/home_cubit.dart';
import 'course_item.dart';

class CoursesList extends StatelessWidget {
  const CoursesList({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<HomeCubit>();
    List<CourseResponseModel> displayedCourses = [];
    if (cubit.coursesOfCategories.isNotEmpty) {
      displayedCourses = cubit.coursesOfCategories[cubit.selectedCategory];
    }
    if (displayedCourses.isEmpty) {
      return EmptyListWidget();
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context,index){
        var course = displayedCourses[index];
        return CourseItem(
          onPressed: () {
            context.read<CourseDetailsCubit>().initial();
            navigate(
                context: context,
                screen: CourseDetailsView(
                  course: course,
                  isSubscribed: false,
                  isReviewedByInstructor: false,
                ));
          },
          course: course,
        );
      },
      itemCount: displayedCourses.length,
      separatorBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.only(
           bottom: 20,
            top: 5,
            left: 20,
            right: 20
          ),
          child: Divider(
            color: Colors.black12,
          ),
        );
      },

    );
  }
}
