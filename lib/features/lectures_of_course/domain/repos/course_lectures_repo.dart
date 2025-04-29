abstract class CourseLecturesRepo {
  Future<List<Map<String,dynamic>>> getAllLectures(String courseId);
}