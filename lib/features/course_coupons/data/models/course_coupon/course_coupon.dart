class CourseCouponModel {
  final String? id;
  final String? coupon;
  final String? courseId;
  final num? discountPercentage;
  final num? userLimit;
  final String? expiryDate;
  final num? numberOfUses;

  CourseCouponModel({
    this.id,
    this.coupon,
    this.courseId,
    this.discountPercentage,
    this.userLimit,
    this.expiryDate,
    this.numberOfUses,
  });

  // Factory constructor to create a CourseCouponModel from JSON
  factory CourseCouponModel.fromJson(Map<String, dynamic> json) {
    return CourseCouponModel(
      id: json['id'] as String?,
      coupon: json['coupon'] as String?,
      courseId: json['courseId'] as String?,
      discountPercentage: json['discountPercentage'] as num?,
      userLimit: json['userLimit'] as num?,
      expiryDate: json['expiryDate'] as String?,
      numberOfUses: json['numberOfUses'] as num?,
    );
  }

  // Method to convert CourseCouponModel back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'coupon': coupon,
      'courseId': courseId,
      'discountPercentage': discountPercentage,
      'userLimit': userLimit,
      'expiryDate': expiryDate,
      'numberOfUses': numberOfUses,
    };
  }
}
