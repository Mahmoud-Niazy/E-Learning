import 'package:e_learning/core/widgets/custom_circular_progress_indicator.dart';
import 'package:e_learning/core/widgets/empty_list_widget.dart';
import 'package:e_learning/features/lecture_details/presentation/manager/lecture_details_cubit/lecture_details_cubit.dart';
import 'package:e_learning/features/lecture_details/presentation/manager/lecture_details_cubit/lecture_details_states.dart';
import 'package:e_learning/features/lecture_details/presentation/views/widgets/note_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class NotesTab extends StatelessWidget {
  const NotesTab({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LectureDetailsCubit>();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: BlocBuilder<LectureDetailsCubit, LectureDetailsStates>(
        builder: (context, state) {
          if(state is GetNotesLoadingState){
            return CustomCircularProgressIndicator();
          }
          if(cubit.notes.isEmpty){
            return EmptyListWidget();
          }
          return ListView.separated(
            itemBuilder: (context, index) {
              return NoteItem(
                index: index + 1,
                note: cubit.notes[index],
              );
            },
            separatorBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20
                ),
                child: Divider(
                  color: Colors.black12,
                ),
              );
            },
            itemCount: cubit.notes.length,
          );
        },
      ),
    );
  }
}
