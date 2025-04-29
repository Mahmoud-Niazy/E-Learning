import 'package:e_learning/features/home/data/models/get_courses_response_model.dart';
import 'package:e_learning/features/user_uploaded_courses/domain/use_cases/get_user_uploaded_courses_use_case.dart';
import 'package:e_learning/features/user_uploaded_courses/presentation/manager/uploaded_courses_cubit/user_uploaded_courses_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserUploadedCoursesCubit extends Cubit<UserUploadedCoursesStates>{

  final GetUserUploadedCoursesUseCase getUserUploadedCoursesUseCase;

  UserUploadedCoursesCubit(this.getUserUploadedCoursesUseCase) : super(UserUploadedCoursesInitialState());

  List<CourseResponseModel> userUploadedCourses = [];

  Future<void> getUserUploadedCourses()async{
    emit(GetUserUploadedCoursesLoadingState());
    try{
      userUploadedCourses = [];
      userUploadedCourses = await getUserUploadedCoursesUseCase.execute();
      emit(GetUserUploadedCoursesSuccessfullyState());
    }
        catch(error){
      emit(GetUserUploadedCoursesErrorState(error.toString()));
        }
  }

}