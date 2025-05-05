import 'package:e_learning/core/utils/app_constance.dart';
import 'package:e_learning/core/utils/app_styles.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/core/widgets/custom_circular_progress_indicator.dart';
import 'package:e_learning/core/widgets/custom_icon_button.dart';
import 'package:e_learning/core/widgets/custom_text_form_field.dart';
import 'package:e_learning/core/widgets/video_player/manager/video_player_cubit/video_player_cubit.dart';
import 'package:e_learning/features/lecture_details/presentation/manager/lecture_details_cubit/lecture_details_cubit.dart';
import 'package:e_learning/features/lecture_details/presentation/manager/lecture_details_cubit/lecture_details_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../../core/methods/show_snack_bar.dart';

class AddNotesTab extends StatelessWidget {
  final String lectureId;
  static var formKey = GlobalKey<FormState>();

  const AddNotesTab({
    super.key,
    required this.lectureId,
  });

  Future<Duration?> getTimeOfVideo(BuildContext context) async {
    Duration? duration =
        await context.read<VideoPlayerCubit>().controller?.position;
    return duration;
  }

  Future<void> addNote(BuildContext context, LectureDetailsCubit cubit) async {
    if (formKey.currentState!.validate()) {
      Duration time = await getTimeOfVideo(context) ?? Duration.zero;
      await cubit.addNote(
        lectureId: lectureId,
        videoSeconds: time,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LectureDetailsCubit>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'time'.tr,
                style: AppStyles.style17,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      isEnabled: false,
                      title: 'time'.tr,
                      controller: cubit.timeController,
                    ),
                  ),
                  CustomIconButton(
                    onPressed: () async {
                      Duration time =
                          await getTimeOfVideo(context) ?? Duration.zero;
                      cubit.setVideoTime(time);
                    },
                    icon: Icons.timer_outlined,
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'video_time_note'.tr,
                style: AppStyles.style13Grey,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'note'.tr,
                style: AppStyles.style17,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                maxLine: 5,
                title: 'note'.tr,
                controller: cubit.noteController,
              ),
              SizedBox(
                height: 30,
              ),
              BlocConsumer<LectureDetailsCubit, LectureDetailsStates>(
                listener: (context, state) async {
                  if (state is AddNoteErrorState) {
                    showErrorSnackBar(context, state.error);
                  }
                  if (state is AddNoteSuccessState) {
                    showSnackBar(
                      context: context,
                      label: 'success'.tr,
                      color: AppConstance.primaryColor,
                    );
                    cubit.emptyNotesFields();
                    cubit.getAllNotes(lectureId);
                  }
                },
                builder: (context, state) {
                  if (state is AddNoteLoadingState) {
                    return CustomCircularProgressIndicator();
                  }
                  return CustomButton(
                    backgroundColor: AppConstance.primaryColor,
                    title: 'confirm'.tr,
                    onPressed: () async {
                      await addNote(context, cubit);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
