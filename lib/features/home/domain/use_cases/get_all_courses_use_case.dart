import 'package:e_learning/features/home/data/models/get_courses_response_model.dart';
import 'package:e_learning/features/home/domain/repos/home_repo.dart';

class GetAllCoursesUseCase {
  final HomeRepo homeRepo;
  GetAllCoursesUseCase(this.homeRepo);

  Future<List<CourseResponseModel>>execute()async{
    var res = await homeRepo.getAllCourses();
    List<CourseResponseModel> allCourses = [];
    if(res.isEmpty){
      return [];
    }
    for(var course in res){
      allCourses.add(CourseResponseModel.fromJson(course));
    }
    return allCourses;
  }
}