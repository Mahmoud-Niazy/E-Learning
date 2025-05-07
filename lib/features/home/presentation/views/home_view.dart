import 'package:e_learning/core/methods/navigation.dart';
import 'package:e_learning/core/utils/app_dimensions.dart';
import 'package:e_learning/core/utils/app_styles.dart';
import 'package:e_learning/core/widgets/custom_circular_progress_indicator.dart';
import 'package:e_learning/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:e_learning/features/home/presentation/views/widgets/carousel_slider.dart';
import 'package:e_learning/features/home/presentation/views/widgets/categories_list.dart';
import 'package:e_learning/features/home/presentation/views/widgets/courses_list.dart';
import 'package:e_learning/features/home/presentation/views/widgets/home_user_image.dart';
import 'package:e_learning/features/notifications/presentation/manager/notifications_cubit/notifications_cubit.dart';
import 'package:e_learning/features/notifications/presentation/manager/notifications_cubit/notifications_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../core/widgets/custom_icon.dart';
import '../../../notifications/presentation/views/notifications_view.dart';
import '../manager/home_cubit/home_states.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        if (state is HomeErrorState) {
          Center(child: Text(state.error));
        }
        return SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'welcome'.tr,
                                style: AppStyles.style25,
                              ),
                              Text(
                                cubit.user?.name ?? "",
                                style: AppStyles.style13Grey,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  navigate(
                                    context: context,
                                    screen: NotificationScreen(),
                                  );
                                  context.read<NotificationsCubit>()
                                      .getAllNotifications();
                                  context.read<NotificationsCubit>()
                                      .makeAllNotificationsSeen();
                                },
                                child: BlocBuilder<NotificationsCubit, NotificationsStates>(
                                  builder: (context, state) {
                                    return Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        CustomIcon(
                                        Icons.notifications_none,
                                        ),
                                        if(state is GetAllNotificationsSuccessState)
                                        if(context.read<NotificationsCubit>().notifications.isNotEmpty)
                                        if(context.read<NotificationsCubit>().notifications.where((n)=> n.seen == false ).toList().isNotEmpty )
                                            Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Text(
                                            '${context.read<NotificationsCubit>().notifications.where((n) => n.seen == false).toList().length}',
                                            overflow: TextOverflow.ellipsis,
                                            style: AppStyles.style11.copyWith(
                                              fontSize: 8,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              HomeUserImage(),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomCarouselSlider(),
                      SizedBox(
                        height: AppDimensions.screenHeight * .005,
                      ),
                      Text(
                        'categories'.tr,
                        style: AppStyles.style20,
                      ),
                      SizedBox(
                        height: AppDimensions.screenHeight * .01,
                      ),
                      CategoriesList(),
                      SizedBox(
                        height: AppDimensions.screenHeight * .035,
                      ),
                      Text(
                        'courses'.tr,
                        style: AppStyles.style20,
                      ),
                      SizedBox(
                        height: AppDimensions.screenHeight * .035,
                      ),
                      CoursesList(),
                    ],
                  ),
                ),
              ),
              if (state is HomeLoadingState) CustomCircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }
}
