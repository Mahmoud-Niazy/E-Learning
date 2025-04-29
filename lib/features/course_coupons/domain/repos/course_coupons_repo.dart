abstract class CourseCouponsRepo {
  Future<List<Map<String, dynamic>>> getCourseCoupons(String courseId);

  Future<void> deleteCoupon({
    required String courseId,
    required String coupon,
  });
}
