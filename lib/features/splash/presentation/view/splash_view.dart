import 'package:e_learning/core/cache_helper/cache_helper.dart';
import 'package:e_learning/core/methods/navigation.dart';
import 'package:e_learning/core/utils/app_assets.dart';
import 'package:e_learning/features/layout/presentation/view/layout_view.dart';
import 'package:e_learning/features/on_boarding/presentation/view/on_boarding_view.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(
        seconds: 3,
      ),
      () {
        navigateAndRemoveUntil(
          context: context,
          // screen: OnBoardingView(),
          screen: CacheHelper.token != null ? const LayoutView() : const OnBoardingView(),

        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppAssets.logo,
          width: screenSize.width*.5,
          height: screenSize.height * .5,
        ),
      ),
    );
  }
}
