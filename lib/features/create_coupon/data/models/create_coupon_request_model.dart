class CreateCouponRequestModel {
  final String? coupon;
  final String? courseId;
  final num? discountPercentage;
  final num? userLimit;
  final String? expiryDate;

  CreateCouponRequestModel({
     this.courseId,
     this.expiryDate,
     this.coupon,
     this.discountPercentage,
     this.userLimit,
});

  Map<String,dynamic> toJson() => {
    "coupon": coupon,
    "courseId": courseId,
    "discountPercentage": discountPercentage,
    "userLimit": userLimit,
    "expiryDate": expiryDate
  };

}