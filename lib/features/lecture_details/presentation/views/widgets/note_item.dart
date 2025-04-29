import 'package:e_learning/core/widgets/custom_icon_button.dart';
import 'package:e_learning/core/widgets/video_player/manager/video_player_cubit/video_player_cubit.dart';
import 'package:e_learning/features/lecture_details/presentation/manager/lecture_details_cubit/lecture_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_constance.dart';
import '../../../../../core/utils/app_dimensions.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../data/models/note_model/note_model.dart';

class NoteItem extends StatelessWidget {
  final int index;
  final NoteModel note;

  const NoteItem({
    super.key,
    required this.index,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LectureDetailsCubit>();
    return Row(
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
          width: AppDimensions.screenWidth * .05,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.note ?? '',
              style: AppStyles.style13,
            ),
            SizedBox(
              width: AppDimensions.screenWidth * .05,
            ),
            Text(
              cubit.secondsToDuration(note.videoSeconds?.toInt() ?? 0).toString().split('.').first,
              style: AppStyles.style11.copyWith(color: Colors.grey),
            ),
          ],
        ),
        Spacer(),
        CustomIconButton(onPressed: () {
          context.read<VideoPlayerCubit>().seekRelative(cubit.secondsToDuration(note.videoSeconds?.toInt() ?? 0));
        }, icon: Icons.play_arrow_outlined)
      ],
    );
  }
}
