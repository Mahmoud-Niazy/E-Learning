class CouponResponseModel {
  final String? id;
  final String? coupon;
  final String? courseId;
  final num? discountPercentage;
  final num? userLimit;
  final String? expiryDate;

  const CouponResponseModel({
    this.id,
    this.coupon,
    this.courseId,
    this.discountPercentage,
    this.userLimit,
    this.expiryDate,
  });

  factory CouponResponseModel.fromJson(Map<String, dynamic> json) {
    return CouponResponseModel(
      id: json['id'] as String?,
      coupon: json['coupon'] as String?,
      courseId: json['courseId'] as String?,
      discountPercentage: json['discountPercentage'] as num?,
      userLimit: json['userLimit'] as num?,
      expiryDate: json['expiryDate'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'coupon': coupon,
      'courseId': courseId,
      'discountPercentage': discountPercentage,
      'userLimit': userLimit,
      'expiryDate': expiryDate,
    };
  }

}
