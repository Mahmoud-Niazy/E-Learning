class PaymentResponseModel {
  final String? paymentIntent;
  final String? ephemeralKey;
  final String? customer;
  final String? publishableKey;

  const PaymentResponseModel({
    this.paymentIntent,
    this.ephemeralKey,
    this.customer,
    this.publishableKey,
  });

  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) {
    return PaymentResponseModel(
      paymentIntent: json['paymentIntent'] as String?,
      ephemeralKey: json['ephemeralKey'] as String?,
      customer: json['customer'] as String?,
      publishableKey: json['publishableKey'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentIntent': paymentIntent,
      'ephemeralKey': ephemeralKey,
      'customer': customer,
      'publishableKey': publishableKey,
    };
  }
}