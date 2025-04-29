import 'package:e_learning/features/lectures_of_course/data/models/lecture_response_model.dart';
import 'package:e_learning/features/lectures_of_course/domain/repos/course_lectures_repo.dart';

class GetCourseLecturesUseCase{

  final CourseLecturesRepo courseLecturesRepo;

  GetCourseLecturesUseCase(this.courseLecturesRepo);

  Future<List<LectureResponseModel>> execute(String courseId)async{
    var res = await courseLecturesRepo.getAllLectures(courseId);
    List<LectureResponseModel> lectures = [];
    for(var lecture in res){
      lectures.add(LectureResponseModel.fromJson(lecture));
    }
    return lectures;
  }

}