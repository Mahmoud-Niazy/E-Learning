import 'package:e_learning/core/api/api_services.dart';
import 'package:e_learning/core/cache_helper/cache_helper.dart';
import 'package:e_learning/features/home/domain/repos/home_repo.dart';

class HomeRepoImp extends HomeRepo {
  final ApiServices apiServices;

  HomeRepoImp(this.apiServices);

  @override
  Future<Map<String, dynamic>> getUserData() async {
    var res = await apiServices.getData(
      path: '/user/data',
      token: CacheHelper.token,
    );
    return res['user'];
  }

  @override
  Future<List<Map<String, dynamic>>> getAllCourses() async {
    var res = await apiServices.getData(
      path: '/courses',
      token: CacheHelper.token,
    );
    return res['courses'].cast<Map<String,dynamic>>();
  }
}
