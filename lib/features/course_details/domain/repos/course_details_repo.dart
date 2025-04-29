
abstract class CourseDetailsRepo {

  Future<Map<String,dynamic>> getCouponData({
    required String courseId,
    required String coupon,
  });

  Future<Map<String,dynamic>> payForCourse({
    required String courseId,
    String? coupon,
  });

}