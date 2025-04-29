abstract class UserUploadedCoursesStates {}

class UserUploadedCoursesInitialState extends UserUploadedCoursesStates{}

class GetUserUploadedCoursesLoadingState extends UserUploadedCoursesStates{}
class GetUserUploadedCoursesSuccessfullyState extends UserUploadedCoursesStates{}
class GetUserUploadedCoursesErrorState extends UserUploadedCoursesStates{
  final String errorMessage ;
  GetUserUploadedCoursesErrorState(this.errorMessage);
}
