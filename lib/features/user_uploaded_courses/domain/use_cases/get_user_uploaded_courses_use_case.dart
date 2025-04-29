import 'package:e_learning/features/home/data/models/get_courses_response_model.dart';
import 'package:e_learning/features/user_uploaded_courses/domain/repos/user_uploaded_courses_repo.dart';

class GetUserUploadedCoursesUseCase {

  final UserUploadedCoursesRepo userUploadedCoursesRepo;
  GetUserUploadedCoursesUseCase(this.userUploadedCoursesRepo);

  Future<List<CourseResponseModel>> execute() async{
    var res = await userUploadedCoursesRepo.getUserUploadedCourses();
    List<CourseResponseModel> userUploadedCourses = [];
    for(var course in res){
      userUploadedCourses.add(CourseResponseModel.fromJson(course));
    }
    return userUploadedCourses;
  }
}