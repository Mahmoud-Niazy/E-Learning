import 'package:dio/dio.dart';
import 'package:e_learning/core/failure/failure.dart';
import 'package:e_learning/features/enrolled_courses/domain/use_cases/get_enrolled_courses_use_case.dart';
import 'package:e_learning/features/enrolled_courses/presentation/manager/enrolled_courses_cubit/enrolled_courses_state.dart';
import 'package:e_learning/features/home/data/models/get_courses_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnrolledCoursesCubit extends Cubit<EnrolledCoursesStates> {
  final GetEnrolledCoursesUseCase getEnrolledCoursesUseCase;

  EnrolledCoursesCubit(
    this.getEnrolledCoursesUseCase,
  ) : super(GetEnrolledCoursesInitialState());

  List<CourseResponseModel> enrolledCourses = [];

  Future<void> getEnrolledCourses() async {
    emit(GetEnrolledCoursesLoadingState());
    try{
      enrolledCourses = await getEnrolledCoursesUseCase.execute();
      emit(GetEnrolledCoursesSuccessState());
    }
    catch(error){
      if(error is DioException){
        emit(GetEnrolledCoursesErrorState(ServerFailure.fromDioException(error).error));
      }
      else{
        emit(GetEnrolledCoursesErrorState(error.toString()));
      }
    }
  }
}
