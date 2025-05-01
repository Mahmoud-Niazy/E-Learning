import 'package:e_learning/features/chat/presentation/manager/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:e_learning/core/utils/app_dimensions.dart';
import 'package:e_learning/features/add_lecture_to_course/presentation/manager/add_new_lecture_cubit.dart';
import 'package:e_learning/features/add_new_course/presentation/manager/add_new_course_cubit.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:e_learning/features/course_coupons/presentation/manager/course_coupons_cubit/course_coupons_cubit.dart';
import 'package:e_learning/features/course_details/presentation/manager/course_details_cubit/course_details_cubit.dart';
import 'package:e_learning/features/create_coupon/presentation/manager/create_coupon_cubit/create_coupon_cubit.dart';
import 'package:e_learning/features/edit_profile/presentation/managers/settings_cubit.dart';
import 'package:e_learning/features/enrolled_courses/presentation/manager/enrolled_courses_cubit/enrolled_courses_cubit.dart';
import 'package:e_learning/features/favourites/presentation/manager/favourites_cubit.dart';
import 'package:e_learning/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:e_learning/features/lectures_of_course/presentation/manager/course_lectures_cubit/course_lectures_cubit.dart';
import 'package:e_learning/features/on_boarding/presentation/manager/page_indicator_cubit/page_indicator_cubit.dart';
import 'package:e_learning/features/search/presentation/manager/search_cubit.dart';
import 'package:e_learning/features/splash/presentation/view/splash_view.dart';
import 'package:e_learning/features/user_uploaded_courses/presentation/manager/uploaded_courses_cubit/user_uploaded_courses_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'core/cache_helper/cache_helper.dart';
import 'core/localization/languages/localization.dart';
import 'core/service_locator/service_locator.dart';
import 'core/widgets/video_player/manager/video_player_cubit/video_player_cubit.dart';
import 'features/layout/presentation/manager/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import 'features/lecture_details/presentation/manager/lecture_details_cubit/lecture_details_cubit.dart';

class ELearningApp extends StatelessWidget {
  const ELearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    ScreenUtil.init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLocator<PageIndicatorCubit>()),
        BlocProvider(create: (context) => serviceLocator<AuthCubit>()),
        BlocProvider(create: (context) => serviceLocator<BottomNavigationBarCubit>()),
        BlocProvider(create: (context) => serviceLocator<HomeCubit>()..impInitialMethods()),
        BlocProvider(create: (context) => serviceLocator<FavouritesCubit>()..getAllFavourites(),lazy: false,),
        BlocProvider(create: (context) => serviceLocator<AddNewCourseCubit>()),
        BlocProvider(create: (context) => serviceLocator<AddNewLectureCubit>()),
        BlocProvider(create: (context) => serviceLocator<SearchCubit>()),
        BlocProvider(create: (context) => serviceLocator<UserUploadedCoursesCubit>()..getUserUploadedCourses()),
        BlocProvider(create: (context) => serviceLocator<EditProfileCubit>()..getUserData()),
        BlocProvider(create: (context) => serviceLocator<CourseLecturesCubit>()),
        BlocProvider(create: (context) => serviceLocator<CreateCouponCubit>()..initial()),
        BlocProvider(create: (context) => serviceLocator<CourseDetailsCubit>()),
        BlocProvider(create: (context) => serviceLocator<EnrolledCoursesCubit>()..getEnrolledCourses()),
        BlocProvider(create: (context) => serviceLocator<CourseCouponsCubit>()),
        BlocProvider(create: (context) => serviceLocator<VideoPlayerCubit>()),
        BlocProvider(create: (context) => serviceLocator<LectureDetailsCubit>()),
        BlocProvider(create: (context) => serviceLocator<ChatCubit>()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            color: Colors.white,
          ),
          canvasColor: Colors.white,
        ),
        locale: CacheHelper.isAr == true ? Locale('ar')  : CacheHelper.isAr == false ? Locale('en') : Get.deviceLocale,
        translations: AppLanguages(),
        home: const SplashView(),
      ),
    );
  }
}