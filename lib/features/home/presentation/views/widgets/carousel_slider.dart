import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_dimensions.dart';
import '../../../../on_boarding/presentation/manager/page_indicator_cubit/page_indicator_cubit.dart';
import '../../../../on_boarding/presentation/manager/page_indicator_cubit/page_indicator_states.dart';
import '../../../../on_boarding/presentation/view/widgets/page_indicator.dart';

class CustomCarouselSlider extends StatelessWidget {
  const CustomCarouselSlider({super.key});

  static List<String> carouselImages = [
    AppAssets.carousel1,
    AppAssets.carousel2,
    AppAssets.carousel3,
    AppAssets.carousel4,
    AppAssets.carousel5,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageIndicatorCubit, PageIndicatorStates>(
      builder: (context, state) {
        var cubit = PageIndicatorCubit.get(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CarouselSlider(
              items: carouselImages.map((image) {
                return Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        image,
                      ),
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: AppDimensions.screenHeight * .3,
                aspectRatio: 16 / 9,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration:
                const Duration(milliseconds: 800),
                autoPlayCurve: Curves.linear,
                enlargeCenterPage: true,
                enlargeFactor: 0.6,
                onPageChanged: (index, x) {
                  cubit.goToNextPage(index);
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
            PageIndicator(
              count: carouselImages.length,
            ),
          ],
        );
      },
    );
  }
}