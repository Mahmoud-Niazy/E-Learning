import 'package:e_learning/core/utils/app_styles.dart';
import 'package:e_learning/core/widgets/custom_circular_progress_indicator.dart';
import 'package:e_learning/core/widgets/empty_list_widget.dart';
import 'package:e_learning/features/course_coupons/data/models/course_coupon/course_coupon.dart';
import 'package:e_learning/features/course_coupons/presentation/manager/course_coupons_cubit/course_coupons_cubit.dart';
import 'package:e_learning/features/course_coupons/presentation/manager/course_coupons_cubit/course_coupons_states.dart';
import 'package:e_learning/features/course_coupons/presentation/views/widget/coupon_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class CourseCouponsView extends StatelessWidget {
  const CourseCouponsView({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CourseCouponsCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'course_coupons'.tr,
          style: AppStyles.style17,
        ),
      ),
      body: BlocBuilder<CourseCouponsCubit, CourseCouponsStates>(
        builder: (context, state) {
          List<CourseCouponModel> coupons = cubit.coupons;
          if (state is GetCourseCouponsLoadingState) {
            return CustomCircularProgressIndicator();
          }
          if(cubit.coupons.isEmpty){
            return EmptyListWidget();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 10
            ),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return CouponItem(
                  coupon: coupons[index],
                  index: index + 1,
                  isActive: cubit.checkIfCouponIsActive(coupons[index]),
                );
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Divider(
                    color: Colors.black12,
                  ),
                );
              },
              itemCount: cubit.coupons.length,
            ),
          );
        },
      ),
    );
  }
}
