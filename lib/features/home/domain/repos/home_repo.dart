
abstract class HomeRepo {
  Future<Map<String,dynamic>>getUserData();

  Future<List<Map<String,dynamic>>> getAllCourses();
}