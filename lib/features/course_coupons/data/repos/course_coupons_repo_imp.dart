import 'package:e_learning/core/api/api_services.dart';
import 'package:e_learning/core/cache_helper/cache_helper.dart';
import 'package:e_learning/features/course_coupons/domain/repos/course_coupons_repo.dart';

class CourseCouponsRepoImp extends CourseCouponsRepo {
  final ApiServices apiServices;

  CourseCouponsRepoImp(this.apiServices);

  @override
  Future<List<Map<String, dynamic>>> getCourseCoupons(String courseId) async {
    var res = await apiServices.getData(
      path: '/coupons/get-course-coupons/$courseId',
      token: CacheHelper.token,
    );
    return res['data'].cast<Map<String, dynamic>>();
  }

  @override
  Future<void> deleteCoupon({
    required String courseId,
    required String coupon,
  }) async {
     await apiServices.deleteData(
      path: '/coupons/delete',
      token: CacheHelper.token,
       data: {
         "coupon": coupon,
         "courseId": courseId,
       },
    );
  }
}
