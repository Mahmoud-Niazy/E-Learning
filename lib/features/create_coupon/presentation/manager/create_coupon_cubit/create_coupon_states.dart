abstract class CreateCouponStates {}

class CreateCouponInitialState extends CreateCouponStates{}

class IncreaseStudentLimitNumber extends CreateCouponStates{}
class DecreaseStudentLimitNumber extends CreateCouponStates{}

class CreateCouponLoadingState extends CreateCouponStates{}
class CreateCouponSuccessState extends CreateCouponStates{}
class CreateCouponErrorState extends CreateCouponStates{
  final String error;
  CreateCouponErrorState(this.error);
}

