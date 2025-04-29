import 'package:e_learning/features/course_coupons/domain/repos/course_coupons_repo.dart';

class DeleteCouponUseCase {
  final CourseCouponsRepo courseCouponsRepo;

  DeleteCouponUseCase(this.courseCouponsRepo);

  Future<void> execute({
    required String courseId,
    required String coupon,
  }) async {
    await courseCouponsRepo.deleteCoupon(
      courseId: courseId,
      coupon: coupon,
    );
  }
}
