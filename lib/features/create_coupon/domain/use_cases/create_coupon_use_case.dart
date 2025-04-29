import 'package:e_learning/features/create_coupon/data/models/create_coupon_request_model.dart';
import 'package:e_learning/features/create_coupon/domain/repos/create_coupon_repo.dart';

class CreateCouponUseCase {

  final CreateCouponRepo createCouponRepo;

  CreateCouponUseCase(this.createCouponRepo);

  Future<void> execute(CreateCouponRequestModel coupon) async{
    await createCouponRepo.createCoupon(coupon);
  }
}