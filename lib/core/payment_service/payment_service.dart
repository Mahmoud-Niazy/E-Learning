import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../utils/app_constance.dart';

class PaymentService {

  Future initPaymentSheet({
    required String clientSecret,
    required String ephemeralKey,
    required String customerStripeId,
  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'Mahmoud Niazy',
        style: ThemeMode.light,
        appearance: PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              background: Colors.white,
              icon: AppConstance.primaryColor,
              primary: AppConstance.primaryColor,
              componentBackground: Colors.blue.shade50,
              componentText: AppConstance.primaryColor,
              secondaryText: AppConstance.primaryColor,
              placeholderText: AppConstance.primaryColor,
            )),
        customerId: customerStripeId,
        customerEphemeralKeySecret: ephemeralKey,
      ),
    );
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment(MakePaymentDataModel paymentData) async {
    await initPaymentSheet(
      clientSecret: paymentData.clientSecret,
      ephemeralKey: paymentData.ephemeralKey,
      customerStripeId: paymentData.customerStripeId,
    );
    await displayPaymentSheet();
  }

}

class MakePaymentDataModel {
  final customerStripeId;
  final String clientSecret; //paymentIntent
  final String ephemeralKey;

  MakePaymentDataModel({
    required this.customerStripeId,
    required this.clientSecret,
    required this.ephemeralKey,
});

}
