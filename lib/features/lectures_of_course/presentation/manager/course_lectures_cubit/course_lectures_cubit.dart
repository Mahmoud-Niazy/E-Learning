import 'package:dio/dio.dart';
import 'package:e_learning/features/lectures_of_course/data/models/lecture_response_model.dart';
import 'package:e_learning/features/lectures_of_course/domain/use_cases/get_course_lectures_use_case.dart';
import 'package:e_learning/features/lectures_of_course/presentation/manager/course_lectures_cubit/course_lectures_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/failure/failure.dart';

class CourseLecturesCubit extends Cubit<CourseLecturesStates> {

  final GetCourseLecturesUseCase getCourseLecturesUseCase;

  CourseLecturesCubit(this.getCourseLecturesUseCase) : super(CourseLecturesInitialState());

  List<LectureResponseModel> courseLectures = [];

  Future<void> getCourseLectures(String courseId)async{
    emit(GetCourseLecturesLoadingState());
    try{
      courseLectures = [];
      courseLectures = await getCourseLecturesUseCase.execute(courseId);
      emit(GetCourseLecturesSuccessState());
    }
        catch(error){
          if (error is DioException) {
            emit(GetCourseLecturesErrorState(ServerFailure.fromDioException(error).error));
          } else {
            emit(GetCourseLecturesErrorState(error.toString()));
          }
        }
  }

}