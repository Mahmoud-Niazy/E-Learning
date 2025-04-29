abstract class AddNewLectureStates{}

class AddNewLectureInitialState extends AddNewLectureStates{}

class NextStepState extends AddNewLectureStates{}
class PreviousStepState extends AddNewLectureStates{}

class SelectCategoryState extends AddNewLectureStates{}

class SelectImageSuccessfully extends AddNewLectureStates{}
class NoImageSelectedState extends AddNewLectureStates{}

class SelectVideoSuccessfully extends AddNewLectureStates{}
class NoVideoSelectedState extends AddNewLectureStates{}

class UploadLectureImageLoadingState extends AddNewLectureStates{}
class UploadLectureImageSuccessfullyState extends AddNewLectureStates{
  final String imageUrl;
  UploadLectureImageSuccessfullyState(this.imageUrl);
}
class UploadLectureImageErrorState extends AddNewLectureStates{
  final String error;
  UploadLectureImageErrorState(this.error);
}


class AddNewLectureLoadingState extends AddNewLectureStates{}
class AddNewLectureSuccessfullyState extends AddNewLectureStates{}
class AddNewLectureErrorState extends AddNewLectureStates{
  final String error;
  AddNewLectureErrorState(this.error);
}

class EmptyLectureDetailsState extends AddNewLectureStates{}

class PrepareLectureDataLoadingState extends AddNewLectureStates{}
class PrepareLectureDataSuccessState extends AddNewLectureStates{}


