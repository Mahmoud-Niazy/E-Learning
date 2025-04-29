import 'package:dio/dio.dart';
import 'package:e_learning/features/home/data/models/get_courses_response_model.dart';
import 'package:e_learning/features/home/domain/use_cases/get_all_courses_use_case.dart';
import 'package:e_learning/features/home/domain/use_cases/get_user_data_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/user_data_model.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {

  final GetUserDataUseCase getUserDataUseCase;
  final GetAllCoursesUseCase getAllCoursesUseCase;

  HomeCubit(this.getUserDataUseCase,this.getAllCoursesUseCase) : super(HomeInitialState());

  Future<void> impInitialMethods()async{
    emit(HomeLoadingState());
    try{
      await getUserData();
      await getCourses();
      emit(HomeSuccessState());
    }
    catch(error){
      if (error is DioException) {
        emit(HomeErrorState(ServerFailure.fromDioException(error).error));
      } else {
        emit(HomeErrorState(error.toString()));
      }
    }
  }

  UserData? user;

  Future<void> getUserData() async {
      user = await getUserDataUseCase.execute();
  }


  Future<void> getCourses() async {
    allCourses = [];
    coursesOfCategories = [];
      allCourses = await getAllCoursesUseCase.execute();
      for (var course in allCourses) {
        if(course.category == 'programming'.tr){
          programmingCourses.add(course);
        }
        if(course.category == 'science'.tr){
          scienceCourses.add(course);
        }
        if(course.category == 'other'.tr){
          otherCourses.add(course);
        }
      }
      coursesOfCategories.addAll([allCourses,programmingCourses,scienceCourses,otherCourses]);


  }

   List<CourseResponseModel> allCourses = [] ;
   List<CourseResponseModel> programmingCourses = [];
   List<CourseResponseModel> scienceCourses = [];
   List<CourseResponseModel> otherCourses = [];

   List<List<CourseResponseModel>> coursesOfCategories = [] ;

  List<CategoryModel> categories = [
    CategoryModel(
      name: 'all'.tr,
      image: AppAssets.allCategory,
    ),
    CategoryModel(
      name: 'programming'.tr,
      image: AppAssets.programmingCategory,
    ),
    CategoryModel(
      name: 'science'.tr,
      image: AppAssets.scienceCategory,
    ),
    CategoryModel(
      name: 'other'.tr,
      image: AppAssets.otherCategory,
    ),
  ];

  int selectedCategory = 0;
  selectCategory(int index){
    selectedCategory = index ;
    emit(SelectCategoryState());
  }
}
