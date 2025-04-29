import 'package:e_learning/core/api/api_services.dart';
import 'package:e_learning/core/cache_helper/cache_helper.dart';
import 'package:e_learning/features/user_uploaded_courses/domain/repos/user_uploaded_courses_repo.dart';

class UserUploadedCoursesRepoImp extends UserUploadedCoursesRepo {
  final ApiServices apiServices;

  UserUploadedCoursesRepoImp(this.apiServices);

  @override
  Future<List<Map<String, dynamic>>> getUserUploadedCourses() async {
    var res = await apiServices.getData(
      path: '/user/uploaded-courses',
      token: CacheHelper.token,
    );
    return res['courses'].cast<Map<String,dynamic>>();
  }
}
