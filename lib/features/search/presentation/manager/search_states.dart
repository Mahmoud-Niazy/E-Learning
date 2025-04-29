abstract class SearchStates{}

class SearchInitialState extends SearchStates{}

class SearchLoadingState extends SearchStates{}
class SearchSuccessfullyState extends SearchStates{}
class SearchErrorState extends SearchStates{
  final String error;
  SearchErrorState(this.error);
}