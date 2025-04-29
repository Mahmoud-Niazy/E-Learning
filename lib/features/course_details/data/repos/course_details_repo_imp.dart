import 'package:e_learning/core/api/api_services.dart';
import 'package:e_learning/core/cache_helper/cache_helper.dart';
import 'package:e_learning/features/course_details/domain/repos/course_details_repo.dart';

class CourseDetailsRepoImp extends CourseDetailsRepo {
  final ApiServices apiServices;

  CourseDetailsRepoImp(this.apiServices);

  @override
  Future<Map<String, dynamic>> getCouponData({
    required String courseId,
    required String coupon,
  }) async {
    var res = await apiServices.postData(
      path: '/coupons/get-coupon-data',
      data: {
        "coupon": coupon,
        "courseId": courseId,
      },
      token: CacheHelper.token,
    );
    return res.data['data'];
  }

  @override
  Future<Map<String, dynamic>> payForCourse({
    required String courseId,
     String? coupon,
}) async {
    var res = await apiServices.postData(
      path: '/payments/payment-sheet',
      data: {
        "courseId": courseId,
        "coupon": coupon,
      },
      token: CacheHelper.token,
    );
    return res.data;
  }
}
