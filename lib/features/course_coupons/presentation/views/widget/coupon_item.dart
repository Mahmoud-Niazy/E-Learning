import 'package:e_learning/core/methods/format_date.dart';
import 'package:e_learning/core/widgets/custom_circular_progress_indicator.dart';
import 'package:e_learning/features/course_coupons/data/models/course_coupon/course_coupon.dart';
import 'package:e_learning/features/course_coupons/presentation/manager/course_coupons_cubit/course_coupons_cubit.dart';
import 'package:e_learning/features/course_coupons/presentation/manager/course_coupons_cubit/course_coupons_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/app_constance.dart';
import '../../../../../core/utils/app_dimensions.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/custom_icon_button.dart';

class CouponItem extends StatelessWidget {
  final CourseCouponModel coupon;
  final num index;
  final bool isActive;

  const CouponItem({
    super.key,
    required this.coupon,
    required this.index,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CourseCouponsCubit>();
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.black26,
        ),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: AppDimensions.screenHeight * .05,
                width: AppDimensions.screenWidth * .1,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppConstance.primaryColor,
                ),
                child: Text(
                  '$index',
                  textAlign: TextAlign.center,
                  style: AppStyles.style20.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                isActive ?
                'active'.tr : 'expired'.tr,
                style: AppStyles.style11.copyWith(
                  color: isActive ? Colors.green : Colors.redAccent,
                ),
              ),
            ],
          ),
          SizedBox(
            width: AppDimensions.screenWidth * .05,
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  coupon.coupon ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.style13,
                ),
                Text(
                  '${'expiry_date'.tr} : ${formatDate(
                      coupon.expiryDate ?? '')}',
                  style: AppStyles.style11.copyWith(
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '${'discount_percent'.tr} : ${coupon.discountPercentage}',
                  style: AppStyles.style11.copyWith(
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '${'student_number_limit'.tr} : ${coupon.userLimit}',
                  style: AppStyles.style11.copyWith(
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '${'number_of_usage'.tr} : ${coupon.numberOfUses}',
                  style: AppStyles.style11.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          BlocConsumer<CourseCouponsCubit, CourseCouponsStates>(
            listener: (context,state){
              if(state is DeleteCouponSuccessState){
                cubit.getCourseCoupons(coupon.courseId ?? '');
              }
            },
            builder: (context, state) {
              if(state is DeleteCouponLoadingState){
                return CustomCircularProgressIndicator();
              }
              return CustomIconButton(
                onPressed: () async{
                  await cubit.deleteCoupon(courseId: coupon.courseId ??'', coupon: coupon.coupon ??'');
                },
                icon: Icons.delete,
                color: Colors.redAccent,
              );
            },
          )
        ],
      ),
    );
  }
}
