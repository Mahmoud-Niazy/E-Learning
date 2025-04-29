import 'package:dio/dio.dart';
import 'package:e_learning/core/failure/failure.dart';
import 'package:e_learning/features/lecture_details/data/models/note_model/note_model.dart';
import 'package:e_learning/features/lecture_details/domain/use_cases/add_note_use_case.dart';
import 'package:e_learning/features/lecture_details/domain/use_cases/get_all_notes_use_case.dart';
import 'package:e_learning/features/lecture_details/presentation/manager/lecture_details_cubit/lecture_details_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LectureDetailsCubit extends Cubit<LectureDetailsStates> {
  final AddNoteUseCase addNoteUseCase;
  final GetAllNotesUseCase getAllNotesUseCase;

  LectureDetailsCubit(
    this.addNoteUseCase,
      this.getAllNotesUseCase,
  ) : super(LectureDetailsInitialState());

  TextEditingController timeController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  List<NoteModel> notes = [];

  Future<void> addNote({
    required String lectureId,
    required Duration videoSeconds,
  }) async {
    emit(AddNoteLoadingState());
    try{
      await addNoteUseCase.execute(
        note: noteController.text,
        lectureId: lectureId,
        videoSeconds: durationToSeconds(videoSeconds).toString(),
      );
      emit(AddNoteSuccessState());
    }
    catch(error){
      if(error is DioException){
        emit(AddNoteErrorState(ServerFailure.fromDioException(error).toString()));
      }
      else{
        emit(AddNoteErrorState(error.toString()));
      }
    }
  }

  void setVideoTime (Duration time){
    timeController.text = time.toString();
  }

  int durationToSeconds(Duration duration) {
    return duration.inSeconds;
  }

  Duration secondsToDuration(int seconds) {
    return Duration(seconds: seconds);
  }


  Future<void> getAllNotes(String lectureId)async{
    emit(GetNotesLoadingState());
    try{
      notes = [];
      notes = await getAllNotesUseCase.execute(lectureId);
      emit(GetNotesSuccessState());
    }
    catch(error){
      if(error is DioException){
        emit(GetNotesErrorState(ServerFailure.fromDioException(error).error));
      }
      else{
        emit(GetNotesErrorState(error.toString()));
      }
    }
  }

  void emptyNotesFields(){
    noteController.text = '';
    timeController.text = '';
  }

}
