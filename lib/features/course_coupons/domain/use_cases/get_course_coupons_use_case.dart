import 'package:e_learning/features/course_coupons/domain/repos/course_coupons_repo.dart';
import '../../data/models/course_coupon/course_coupon.dart';

class GetCourseCouponsUseCase{

  final CourseCouponsRepo courseCouponsRepo;
  GetCourseCouponsUseCase(this.courseCouponsRepo);

  Future<List<CourseCouponModel>> execute(String courseId)async{
    var res = await courseCouponsRepo.getCourseCoupons(courseId);
    List<CourseCouponModel> coupons = [];
    for(var course in res){
      coupons.add(CourseCouponModel.fromJson(course));
    }
    return coupons;
  }

}