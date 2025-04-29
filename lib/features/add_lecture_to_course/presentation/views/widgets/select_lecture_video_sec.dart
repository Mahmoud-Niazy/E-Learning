import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/widgets/custom_text_button.dart';
import '../../manager/add_new_lecture_cubit.dart';
import '../../manager/add_new_lecture_states.dart';

class SelectLectureVideoSec extends StatelessWidget {
  const SelectLectureVideoSec({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocBuilder<AddNewLectureCubit, AddNewLectureStates>(
      builder: (context, state) {
        var cubit = context.read<AddNewLectureCubit>();
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
                      title: 'select_lecture_video'.tr,
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