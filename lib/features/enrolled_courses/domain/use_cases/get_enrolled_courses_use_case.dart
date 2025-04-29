import 'package:e_learning/features/home/data/models/get_courses_response_model.dart';

import '../repos/enrolled_courses_repo.dart';

class GetEnrolledCoursesUseCase {
  final EnrolledCoursesRepo enrolledCoursesRepo;

  GetEnrolledCoursesUseCase(this.enrolledCoursesRepo);
  
  Future<List<CourseResponseModel>> execute()async{
    var res = await enrolledCoursesRepo.getEnrolledCourses();
    List<CourseResponseModel> enrolledCourses = [];
    for(var course in res){
      enrolledCourses.add(CourseResponseModel.fromJson(course));
    }
    return enrolledCourses;
  }

}