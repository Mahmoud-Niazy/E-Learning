import 'package:flutter/material.dart';

import '../../manager/page_indicator_cubit/page_indicator_cubit.dart';

class PageIndicator extends StatelessWidget {
  final int count;

  const PageIndicator({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height * .1,
      width: 65,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: PageIndicatorCubit.get(context).currentIndex == index
                  ? Colors.blue
                  : Colors.black26,
            ),
            width: PageIndicatorCubit.get(context).currentIndex == index
                ? 10
                : 8,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 5,
          );
        },
        itemCount: count,
      ),
    );
  }
}
