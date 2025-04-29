import 'package:e_learning/core/api/api_services.dart';
import 'package:e_learning/features/search/domain/repos/search_repo.dart';

import '../../../../core/cache_helper/cache_helper.dart';

class SearchRepoImp extends SearchRepo{
  final ApiServices apiServices;
  SearchRepoImp(this.apiServices);

  @override
  Future<List<Map<String, dynamic>>> getAllCourses() async {
    var res = await apiServices.getData(
      path: '/courses',
      token: CacheHelper.token,
    );
    return res['courses'].cast<Map<String,dynamic>>();
  }
}