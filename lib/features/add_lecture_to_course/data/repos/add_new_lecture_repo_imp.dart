import 'package:e_learning/core/api/api_services.dart';
import 'package:e_learning/core/cache_helper/cache_helper.dart';

import '../../domain/repos/add_new_lecture_repo.dart';

class AddNewLectureRepoImp extends AddNewLectureRepo {
  final ApiServices apiServices;

  AddNewLectureRepoImp(this.apiServices);

  @override
  Future<void> addNewLecture(dynamic data) async {
    await apiServices.postData(
      token: CacheHelper.token,
      path: '/lectures/create',
      data: data,
    );
  }

  @override
  Future<void> updateLecture(dynamic data) async {
    await apiServices.patchData(
      token: CacheHelper.token,
      path: '/lectures',
      data: data,
    );
  }
}
