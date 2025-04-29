
abstract class HomeStates {}

class HomeInitialState extends HomeStates{}

class HomeLoadingState extends HomeStates{}
class HomeSuccessState extends HomeStates{}
class HomeErrorState extends HomeStates{
  final String error;
  HomeErrorState(this.error);
}


// class GetUserDataLoadingState extends HomeStates{}
// class GetUserDataSuccessfullyState extends HomeStates{
//   GetUserDataSuccessfullyState();
// }
// class GetUserDataErrorState extends HomeStates{
//   final String error;
//   GetUserDataErrorState(this.error);
// }
//
// class GetCoursesLoadingState extends HomeStates{}
// class GetCoursesSuccessfullyState extends HomeStates{
//
// }
// class GetCoursesErrorState extends HomeStates{
//   final String error;
//   GetCoursesErrorState(this.error);
// }

class SelectCategoryState extends HomeStates{}


