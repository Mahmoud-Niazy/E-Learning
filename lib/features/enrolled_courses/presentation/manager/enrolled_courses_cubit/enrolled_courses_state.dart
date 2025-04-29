abstract class EnrolledCoursesStates {}

class GetEnrolledCoursesInitialState extends EnrolledCoursesStates{}

class GetEnrolledCoursesLoadingState extends EnrolledCoursesStates{}
class GetEnrolledCoursesSuccessState extends EnrolledCoursesStates{}
class GetEnrolledCoursesErrorState extends EnrolledCoursesStates{
  final String error;
  GetEnrolledCoursesErrorState(this.error);
}