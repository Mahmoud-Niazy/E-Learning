import 'package:e_learning/features/course_details/data/models/payment_response_model/payment_response_model.dart';
import 'package:e_learning/features/course_details/domain/repos/course_details_repo.dart';

class PayForCourseUseCase {
  final CourseDetailsRepo courseDetailsRepo;

  PayForCourseUseCase(this.courseDetailsRepo);

  Future<PaymentResponseModel> execute({
    required String courseId,
    String? coupon,
  }) async {
    var res = await courseDetailsRepo.payForCourse(
      courseId: courseId,
      coupon: coupon,
    );
    PaymentResponseModel paymentResponseModel = PaymentResponseModel.fromJson(res);
    return paymentResponseModel;
  }
}
