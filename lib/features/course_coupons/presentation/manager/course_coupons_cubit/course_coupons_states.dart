abstract class CourseCouponsStates{}

class CourseCouponsInitialState extends CourseCouponsStates{}

class GetCourseCouponsLoadingState extends CourseCouponsStates{}
class GetCourseCouponsSuccessState extends CourseCouponsStates{}
class GetCourseCouponsErrorState extends CourseCouponsStates{
  final String error;
  GetCourseCouponsErrorState(this.error);
}

class DeleteCouponLoadingState extends CourseCouponsStates{}
class DeleteCouponSuccessState extends CourseCouponsStates{}
class DeleteCouponErrorState extends CourseCouponsStates{
  final String error;
  DeleteCouponErrorState(this.error);
}



