import 'package:e_learning/core/methods/navigation.dart';
import 'package:e_learning/core/utils/app_constance.dart';
import 'package:e_learning/core/utils/app_styles.dart';
import 'package:e_learning/features/auth/presentation/views/login_view.dart';
import 'package:e_learning/features/on_boarding/presentation/view/widgets/page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../data/models/on_boarding_data_model.dart';
import '../manager/page_indicator_cubit/page_indicator_cubit.dart';
import '../manager/page_indicator_cubit/page_indicator_states.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    var pageController = PageController();
    var screenSize = MediaQuery.of(context).size;

    List<OnBoardingDataModel> onBoardingData = [
      OnBoardingDataModel(
        image: AppAssets.onBoarding1,
        title: 'on_boarding_title_1'.tr,
        subtitle: 'on_boarding_sub_title_1'.tr,
      ),
      OnBoardingDataModel(
        image: AppAssets.onBoarding2,
        title: 'on_boarding_title_2'.tr,
        subtitle: 'on_boarding_sub_title_2'.tr,
      ),
      OnBoardingDataModel(
        image: AppAssets.onBoarding3,
        title: 'on_boarding_title_3'.tr,
        subtitle: 'on_boarding_sub_title_3'.tr,
      ),
    ];
    return BlocProvider(
      create: (context) => PageIndicatorCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Lottie.asset(
                          onBoardingData[index].image,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(height: screenSize.height * .05),
                          Text(
                            onBoardingData[index].title,
                            style: AppStyles.style20Bold,
                          ),
                          SizedBox(height: screenSize.height * .02),
                          Text(
                            textAlign: TextAlign.center,
                            onBoardingData[index].subtitle,
                            style: AppStyles.style15Grey,
                          ),
                        ],
                      ),
                    ],
                  );
                },
                itemCount: onBoardingData.length,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width * .05,
              vertical: 15),
              child: BlocBuilder<PageIndicatorCubit, PageIndicatorStates>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PageIndicator(
                        count: onBoardingData.length,
                      ),
                      Expanded(
                        child: CustomButton(
                          onPressed: () {
                            if (PageIndicatorCubit.get(context).currentIndex ==
                                onBoardingData.length - 1) {
                              navigateAndRemoveUntil(
                                context: context,
                                screen: const LoginView(),
                              );
                            } else {
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.linear,
                              );
                              PageIndicatorCubit.get(context).goToNextPage(
                                  pageController.page!.toInt() + 1);
                            }
                          },
                          backgroundColor: AppConstance.primaryColor,
                          title: PageIndicatorCubit.get(context).currentIndex ==
                                  onBoardingData.length - 1
                              ? 'get_started'.tr
                              : 'next'.tr,
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
