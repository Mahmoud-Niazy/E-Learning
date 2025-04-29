import 'package:e_learning/core/api/api_services.dart';
import 'package:e_learning/core/cache_helper/cache_helper.dart';

import '../../domain/repos/enrolled_courses_repo.dart';

class EnrolledCoursesRepoImp extends EnrolledCoursesRepo {
  final ApiServices apiServices;

  EnrolledCoursesRepoImp(this.apiServices);

  @override
  Future<List<Map<String, dynamic>>> getEnrolledCourses() async {
    var res = await apiServices.getData(
      path: '/user/enrolled-courses',
      token: CacheHelper.token,
    );
    return res['courses'].cast<Map<String,dynamic>>();
  }
}
