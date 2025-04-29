import 'package:e_learning/core/api/api_services.dart';
import 'package:e_learning/core/cache_helper/cache_helper.dart';

import '../../domain/repos/add_new_course_repo.dart';

class AddNewCourseRepoImp extends AddNewCourseRepo {
  final ApiServices apiServices;

  AddNewCourseRepoImp(this.apiServices);

  @override
  Future<void> addNewCourse(dynamic data) async {
    await apiServices.postData(
      token: CacheHelper.token,
      path: '/courses',
      data: data,
    );
  }

  @override
  Future<void> updateCourse(dynamic data) async {
    await apiServices.patchData(
      token: CacheHelper.token,
      path: '/courses',
      data: data,
    );
  }
}
