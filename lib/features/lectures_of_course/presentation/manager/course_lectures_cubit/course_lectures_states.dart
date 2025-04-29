abstract class CourseLecturesStates {}

class CourseLecturesInitialState extends CourseLecturesStates{}

class GetCourseLecturesLoadingState extends CourseLecturesStates{}
class GetCourseLecturesSuccessState extends CourseLecturesStates{}
class GetCourseLecturesErrorState extends CourseLecturesStates{
  final String error;
  GetCourseLecturesErrorState(this.error);
}
