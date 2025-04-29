abstract class AddNewCourseStates{}

class AddNewCourseInitialState extends AddNewCourseStates{}

class NextStepState extends AddNewCourseStates{}
class PreviousStepState extends AddNewCourseStates{}

class SelectCategoryState extends AddNewCourseStates{}

class SelectImageSuccessfully extends AddNewCourseStates{}
class NoImageSelectedState extends AddNewCourseStates{}

class SelectVideoSuccessfully extends AddNewCourseStates{}
class NoVideoSelectedState extends AddNewCourseStates{}

class UploadCourseImageLoadingState extends AddNewCourseStates{}
class UploadCourseImageSuccessfullyState extends AddNewCourseStates{
  final String imageUrl;
  UploadCourseImageSuccessfullyState(this.imageUrl);
}
class UploadCourseImageErrorState extends AddNewCourseStates{
  final String error;
  UploadCourseImageErrorState(this.error);
}


class AddNewCourseLoadingState extends AddNewCourseStates{}
class AddNewCourseSuccessfullyState extends AddNewCourseStates{}
class AddNewCourseErrorState extends AddNewCourseStates{
  final String error;
  AddNewCourseErrorState(this.error);
}

class EmptyCourseDetailsState extends AddNewCourseStates{}

class PrepareCourseDataLoadingState extends AddNewCourseStates{}
class PrepareCourseDataSuccessState extends AddNewCourseStates{}


