import 'package:dio/dio.dart';
import 'package:e_learning/core/failure/failure.dart';
import 'package:e_learning/features/course_coupons/data/models/course_coupon/course_coupon.dart';
import 'package:e_learning/features/course_coupons/domain/use_cases/delete_coupon_use_case.dart';
import 'package:e_learning/features/course_coupons/domain/use_cases/get_course_coupons_use_case.dart';
import 'package:e_learning/features/course_coupons/presentation/manager/course_coupons_cubit/course_coupons_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseCouponsCubit extends Cubit<CourseCouponsStates> {
  final GetCourseCouponsUseCase getCourseCouponsUseCase;
  final DeleteCouponUseCase deleteCouponUseCase;

  CourseCouponsCubit(
    this.getCourseCouponsUseCase,
    this.deleteCouponUseCase,
  ) : super(CourseCouponsInitialState());

  List<CourseCouponModel> coupons = [];

  Future<void> getCourseCoupons(String courseId) async {
    coupons = [];
    emit(GetCourseCouponsLoadingState());
    try {
      coupons = await getCourseCouponsUseCase.execute(courseId);
      emit(GetCourseCouponsSuccessState());
    } catch (error) {
      if (error is DioException) {
        emit(GetCourseCouponsErrorState(
            ServerFailure.fromDioException(error).error));
      } else {
        emit(GetCourseCouponsErrorState(error.toString()));
      }
    }
  }

  bool checkIfCouponIsActive(CourseCouponModel coupon) {
    try {
      DateTime expiryDate = DateTime.parse(coupon.expiryDate ?? '');
      DateTime dateNow = DateTime.now();
      if (expiryDate.isBefore(dateNow)) {
        return false;
      }
      if (coupon.numberOfUses! >= coupon.userLimit!) {
        return false;
      }
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<void> deleteCoupon({
    required String courseId,
    required String coupon,
  }) async {
    emit(DeleteCouponLoadingState());
    try{
      await deleteCouponUseCase.execute(
        courseId: courseId,
        coupon: coupon,
      );
      emit(DeleteCouponSuccessState());
    }
    catch(error){
      if(error is DioException){
        emit(DeleteCouponErrorState(ServerFailure.fromDioException(error).error));
      }
      else{
        emit(DeleteCouponErrorState(error.toString()));
      }
    }
  }


}
