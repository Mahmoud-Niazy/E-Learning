import 'package:e_learning/core/api/api_services.dart';
import 'package:e_learning/core/cache_helper/cache_helper.dart';
import 'package:e_learning/core/service_locator/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'core/app_secret_keys/app_secret_keys.dart';
import 'e_learning_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Stripe.publishableKey = AppSecretKeys.stripePublishableKey;
  await CacheHelper.init();
  ServiceLocator.init();
  ApiServices.init();
  await ScreenUtil.ensureScreenSize();
  runApp(const ELearningApp());
}

