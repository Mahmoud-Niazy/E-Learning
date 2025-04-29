import 'package:dio/dio.dart';
import 'package:e_learning/core/payment_service/payment_service.dart';
import 'package:e_learning/features/course_details/data/models/coupon_response_model/coupon_response_model.dart';
import 'package:e_learning/features/course_details/data/models/payment_response_model/payment_response_model.dart';
import 'package:e_learning/features/course_details/domain/use_cases/get_coupon_data_use_case.dart';
import 'package:e_learning/features/course_details/domain/use_cases/pay_for_course_use_case.dart';
import 'package:e_learning/features/course_details/presentation/manager/course_details_cubit/course_details_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/failure/failure.dart';

class CourseDetailsCubit extends Cubit<CourseDetailsStates> {
  final GetCouponDataUseCase getCouponDataUseCase;
  final PayForCourseUseCase payForCourseUseCase;

  CourseDetailsCubit(
    this.getCouponDataUseCase,
    this.payForCourseUseCase,
  ) : super(CourseDetailsInitialState());

  CouponResponseModel? couponData;
  PaymentResponseModel? paymentData;

  TextEditingController couponCodeController = TextEditingController();

  void initial() {
    couponCodeController.text = '';
    couponData = null;
  }

  Future<void> getCouponData(String courseId) async {
    emit(GetCouponDataLoadingState());
    try {
      CouponResponseModel data = await getCouponDataUseCase.execute(
        courseId: courseId,
        coupon: couponCodeController.text,
      );
      couponData = data;
      emit(GetCouponDataSuccessState());
    } catch (error) {
      if (error is DioException) {
        emit(GetCouponDataErrorState(
            ServerFailure.fromDioException(error).error));
      } else {
        emit(GetCouponDataErrorState(error.toString()));
      }
    }
  }

  Future<void> payForCourse(String courseId) async {
    emit(PayForCourseLoadingState());
    try {
      paymentData = await payForCourseUseCase.execute(
        courseId: courseId,
        coupon: couponData?.coupon,
      );
      if(paymentData != null){
        await PaymentService().makePayment(
          MakePaymentDataModel(
            customerStripeId: paymentData!.customer ?? '',
            clientSecret: paymentData!.paymentIntent ?? '',
            ephemeralKey: paymentData!.ephemeralKey ?? '',
          ),
        );
      }
      emit(PayForCourseSuccessState());

    } catch (error) {
      if (error is DioException) {
        emit(PayForCourseErrorState(
            ServerFailure.fromDioException(error).error));
      } else {
        emit(PayForCourseErrorState(error.toString()));
      }
    }
  }
}
