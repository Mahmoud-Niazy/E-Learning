import 'package:e_learning/core/api/api_services.dart';
import 'package:e_learning/core/cache_helper/cache_helper.dart';
import 'package:e_learning/features/create_coupon/data/models/create_coupon_request_model.dart';
import 'package:e_learning/features/create_coupon/domain/repos/create_coupon_repo.dart';

class CreateCouponRepoImp extends CreateCouponRepo {
  final ApiServices apiServices;

  CreateCouponRepoImp(this.apiServices);

  @override
  Future<void> createCoupon(CreateCouponRequestModel coupon) async {
    await apiServices.postData(
      path: '/coupons/create',
      data: coupon.toJson(),
      token: CacheHelper.token,
    );
  }
}
