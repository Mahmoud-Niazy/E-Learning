import 'package:e_learning/core/utils/app_constance.dart';
import 'package:e_learning/core/utils/app_dimensions.dart';
import 'package:e_learning/core/utils/app_styles.dart';
import 'package:e_learning/features/home/data/models/get_courses_response_model.dart';
import 'package:e_learning/features/lecture_details/presentation/views/widgets/add_notes_tab.dart';
import 'package:e_learning/features/lecture_details/presentation/views/widgets/notes_tab_.dart';
import 'package:e_learning/features/lectures_of_course/data/models/lecture_response_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/video_player/view/video_player.dart';

class LecturesDetailsView extends StatelessWidget {
  final LectureResponseModel lecture;
  final CourseInstructorResponse? instructor;

  const LecturesDetailsView({
    super.key,
    required this.lecture,
    required this.instructor,
  });

  @override
  Widget build(BuildContext context) {
    var screenHeight = AppDimensions.screenHeight;
    var screenWidth = AppDimensions.screenWidth;
    // var cubit = context.read<VideoPlayerCubit>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (lecture.videoUrl != null && lecture.videoUrl != '')
              CustomVideoPlayer(videoUrl: lecture.videoUrl!),
            SizedBox(
              height: screenHeight * .03,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lecture.title ?? '',
                    style: AppStyles.style17,
                  ),
                  SizedBox(
                    height: screenHeight * .01,
                  ),
                  Text(
                    lecture.title ?? '',
                    style: AppStyles.style15Grey,
                  ),
                  SizedBox(
                    height: screenHeight * .04,
                  ),
                  if (instructor != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'instructor'.tr,
                          style: AppStyles.style17,
                        ),
                        SizedBox(
                          height: screenHeight * .02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (instructor!.userProfileImage != null &&
                                instructor!.userProfileImage != '')
                              Container(
                                height: screenHeight * .05,
                                width: screenWidth * .2,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      instructor!.userProfileImage!,
                                    ),
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            Text(
                              instructor!.name ?? '',
                              style: AppStyles.style13,
                            ),
                          ],
                        ),
                      ],
                    ),
                  SizedBox(
                    height: screenHeight * .04,
                  ),
                  DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        TabBar(
                          indicatorColor: AppConstance.primaryColor,
                          labelColor: AppConstance.primaryColor,
                          tabs: [
                            Tab(text: 'notes'.tr),
                            Tab(text: 'add_notes'.tr),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * .65,
                          child: TabBarView(
                            children: [
                              NotesTab(),
                              AddNotesTab(
                                lectureId: lecture.lectureId ?? '',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
