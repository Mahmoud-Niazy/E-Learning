import 'package:dio/dio.dart';
import 'package:e_learning/features/create_coupon/domain/use_cases/create_coupon_use_case.dart';
import 'package:e_learning/features/create_coupon/presentation/manager/create_coupon_cubit/create_coupon_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/failure/failure.dart';
import '../../../data/models/create_coupon_request_model.dart';

class CreateCouponCubit extends Cubit<CreateCouponStates>{

  final CreateCouponUseCase createCouponUseCase;

  CreateCouponCubit(this.createCouponUseCase) : super(CreateCouponInitialState());

  TextEditingController discountPercentController = TextEditingController();
  TextEditingController studentLimitController = TextEditingController();
  TextEditingController couponController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();


  Future<void> createCoupon(String courseId) async{
    emit(CreateCouponLoadingState());
    try{
      CreateCouponRequestModel coupon = CreateCouponRequestModel(
        courseId: courseId,
        coupon: couponController.text,
        discountPercentage: num.parse(discountPercentController.text),
        expiryDate: expiryDateController.text,
        userLimit: num.parse(studentLimitController.text),
      );
      await createCouponUseCase.execute(coupon);
      emit(CreateCouponSuccessState());
      initial();
    }
    catch(error){
      if (error is DioException) {
        emit(CreateCouponErrorState(ServerFailure.fromDioException(error).error));
      } else {
        emit(CreateCouponErrorState(error.toString()));
      }    }

  }

  String generateShortSecureKey() {
    var uuid = Uuid();
    return uuid.v4();
  }

  void autoGenerateCouponCode(String courseId){
    couponController.text = generateShortSecureKey();
  }

  String getDateAfter7Days() {
    final now = DateTime.now();
    final futureDate = now.add(Duration(days: 7));
    return "${futureDate.year.toString().padLeft(4, '0')}-${futureDate.month.toString().padLeft(2, '0')}-${futureDate.day.toString().padLeft(2, '0')}";
  }

  void initial(){
    discountPercentController.text = '';
    couponController.text = '';
    studentLimitController.text = '1';
    expiryDateController.text = getDateAfter7Days();
  }

  void increaseStudentLimitNumber(){
    studentLimitController.text = (num.parse(studentLimitController.text) + 1).toString();
    emit(IncreaseStudentLimitNumber());
  }

  void decreaseStudentLimitNumber(){
    if(num.parse(studentLimitController.text) > 1){
      studentLimitController.text = (num.parse(studentLimitController.text) - 1).toString();
      emit(IncreaseStudentLimitNumber());
    }
  }


}