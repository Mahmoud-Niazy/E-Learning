import 'dart:developer';

import 'package:e_learning/core/api/api_services.dart';

import '../../../../core/cache_helper/cache_helper.dart';
import '../../domain/repos/course_lectures_repo.dart';

class CourseLecturesRepoImp extends CourseLecturesRepo{

  final ApiServices apiServices;
  CourseLecturesRepoImp(this.apiServices);

  @override
  Future<List<Map<String, dynamic>>> getAllLectures(String courseId) async{
    var res = await apiServices.postData(
        path: '/lectures',
        data: {
      "courseId" : courseId,
    },
      token: CacheHelper.token,
    );
    return res.data['lectures'].cast<Map<String,dynamic>>();
  }

}