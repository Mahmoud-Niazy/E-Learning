import 'package:e_learning/core/api/api_services.dart';
import 'package:e_learning/core/cache_helper/cache_helper.dart';
import '../../domain/repos/favourites_repo.dart';

class FavouritesRepoImp extends FavouritesRepo {
  final ApiServices apiServices;

  FavouritesRepoImp(this.apiServices);

  @override
  Future<void> addToFavourites(String courseId) async {
    await apiServices.postData(
      path: "/courses/fav/$courseId",
      token: CacheHelper.token,
      data: {},
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getAllFavourites() async {
    var res = await apiServices.getData(
      path: '/courses/fav',
      token: CacheHelper.token,
    );
    return res['courses'].cast<Map<String,dynamic>>();
  }

  @override
  Future<void> removeFromFavourites(String courseId) async {
    await apiServices.deleteData(
      path: "/courses/fav/$courseId",
      token: CacheHelper.token,
    );
  }
}
