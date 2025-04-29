import 'package:dio/dio.dart';
import 'package:e_learning/features/home/data/models/get_courses_response_model.dart';
import 'package:e_learning/features/home/domain/use_cases/get_all_courses_use_case.dart';
import 'package:e_learning/features/search/presentation/manager/search_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/failure/failure.dart';


class SearchCubit extends Cubit<SearchStates> {
  final GetAllCoursesUseCase getAllCoursesUseCase;

  SearchCubit(this.getAllCoursesUseCase) : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of<SearchCubit>(context);

  List<CourseResponseModel> allCourses = [];

  Future<void> getCourses() async {
    allCourses = await getAllCoursesUseCase.execute();
  }

  List<CourseResponseModel> searchResults = [];
  TextEditingController searchController = TextEditingController();

  Future<List<CourseResponseModel>?> search() async {
    searchResults = [];
    emit(SearchLoadingState());
    try{
      await getCourses();
      for(var course in allCourses){
        if(course.title == null){
          continue;
        }
        if(course.title!.contains(searchController.text)){
          searchResults.add(course);
        }
      }
      emit(SearchSuccessfullyState());
      return searchResults;
    }
    catch(error){
      if (error is DioException) {
        emit(SearchErrorState(ServerFailure.fromDioException(error).error));
      } else {
        emit(SearchErrorState(error.toString()));
      }
      return null;
    }

  }

}
