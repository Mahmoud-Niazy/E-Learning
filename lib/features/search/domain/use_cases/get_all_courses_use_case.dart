import 'package:e_learning/features/home/data/models/get_courses_response_model.dart';
import 'package:e_learning/features/search/domain/repos/search_repo.dart';

class GetAllCoursesForSearchUseCase {
  final SearchRepo searchRepo;
  GetAllCoursesForSearchUseCase(this.searchRepo);

  Future<List<CourseResponseModel>>execute()async{
    var res = await searchRepo.getAllCourses();
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