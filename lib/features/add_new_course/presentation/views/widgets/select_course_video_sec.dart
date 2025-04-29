import 'package:e_learning/features/add_new_course/presentation/manager/add_new_course_cubit.dart';
import 'package:e_learning/features/add_new_course/presentation/manager/add_new_course_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/widgets/custom_text_button.dart';

class SelectCourseVideoSec extends StatelessWidget {
  const SelectCourseVideoSec({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocBuilder<AddNewCourseCubit, AddNewCourseStates>(
      builder: (context, state) {
        var cubit = context.read<AddNewCourseCubit>();
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black38,
              ),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      AppAssets.video,
                      height: 30,
                      width: 30,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: CustomTextButton(
                      title: 'select_intro_video'.tr,
                      onPressed: () {
                        cubit.pickVideoFromGallery();
                      },
                    ),
                  ),
                ],
              ),
              if(cubit.pickedVideo != null)
                Container(
                  height: screenSize.height * .3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: VideoPlayer(cubit.videoPlayedController!),
                ),

            ],
          ),
        );
      },
    );
  }
}