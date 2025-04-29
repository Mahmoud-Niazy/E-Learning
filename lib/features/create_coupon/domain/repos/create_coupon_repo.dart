import '../../data/models/create_coupon_request_model.dart';

abstract class CreateCouponRepo {
  Future<void> createCoupon(CreateCouponRequestModel coupon);
}