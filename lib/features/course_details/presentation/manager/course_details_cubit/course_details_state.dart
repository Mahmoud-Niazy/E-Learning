abstract class CourseDetailsStates {}

class CourseDetailsInitialState extends CourseDetailsStates{}

class GetCouponDataLoadingState extends CourseDetailsStates{}
class GetCouponDataSuccessState extends CourseDetailsStates{}
class GetCouponDataErrorState extends CourseDetailsStates{
  final String error;
  GetCouponDataErrorState(this.error);
}

class PayForCourseLoadingState extends CourseDetailsStates{}
class PayForCourseSuccessState extends CourseDetailsStates{}
class PayForCourseErrorState extends CourseDetailsStates{
  final String error;
  PayForCourseErrorState(this.error);
}