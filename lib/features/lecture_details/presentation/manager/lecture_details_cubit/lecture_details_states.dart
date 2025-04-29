abstract class LectureDetailsStates {}

class LectureDetailsInitialState extends LectureDetailsStates{}

class AddNoteLoadingState extends LectureDetailsStates{}
class AddNoteSuccessState extends LectureDetailsStates{}
class AddNoteErrorState extends LectureDetailsStates{
  final String error;
  AddNoteErrorState(this.error);
}

class GetNotesLoadingState extends LectureDetailsStates{}
class GetNotesSuccessState extends LectureDetailsStates{}
class GetNotesErrorState extends LectureDetailsStates{
  final String error;
  GetNotesErrorState(this.error);
}