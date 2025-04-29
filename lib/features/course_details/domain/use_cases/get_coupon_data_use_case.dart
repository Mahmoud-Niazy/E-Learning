import 'package:e_learning/features/course_details/data/models/coupon_response_model/coupon_response_model.dart';
import 'package:e_learning/features/course_details/domain/repos/course_details_repo.dart';

class GetCouponDataUseCase {
  final CourseDetailsRepo courseDetailsRepo;

  GetCouponDataUseCase(this.courseDetailsRepo);

  Future<CouponResponseModel> execute({
    required String courseId,
    required String coupon,
  }) async {
    var res = await courseDetailsRepo.getCouponData(
      courseId: courseId,
      coupon: coupon,
    );
    CouponResponseModel couponData = CouponResponseModel.fromJson(res);
    return couponData;
  }

}
