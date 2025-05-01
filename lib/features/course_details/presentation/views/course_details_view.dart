import 'package:e_learning/core/methods/navigation.dart';
import 'package:e_learning/core/utils/app_constance.dart';
import 'package:e_learning/core/utils/app_styles.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/core/widgets/custom_circular_progress_indicator.dart';
import 'package:e_learning/core/widgets/custom_text_button.dart';
import 'package:e_learning/core/widgets/custom_text_form_field.dart';
import 'package:e_learning/features/course_details/presentation/manager/course_details_cubit/course_details_cubit.dart';
import 'package:e_learning/features/course_details/presentation/manager/course_details_cubit/course_details_state.dart';
import 'package:e_learning/features/course_details/presentation/views/widgets/instructor_details.dart';
import 'package:e_learning/features/enrolled_courses/presentation/manager/enrolled_courses_cubit/enrolled_courses_cubit.dart';
import 'package:e_learning/features/home/data/models/get_courses_response_model.dart';
import 'package:e_learning/features/layout/presentation/view/layout_view.dart';
import 'package:e_learning/features/lectures_of_course/presentation/manager/course_lectures_cubit/course_lectures_cubit.dart';
import 'package:e_learning/features/lectures_of_course/presentation/views/course_lectures_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import '../../../../core/cache_helper/cache_helper.dart';
import '../../../../core/methods/show_snack_bar.dart';
import '../../../../core/methods/translate.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/widgets/video_player/view/video_player.dart';
import '../../../home/data/models/category_model.dart';
import '../../../home/presentation/manager/home_cubit/home_cubit.dart';

class CourseDetailsView extends StatelessWidget {
  final CourseResponseModel course;
  final List<CategoryModel> categories = [
    CategoryModel(
      image: AppAssets.programmingCategory,
      name: 'Programming',
    ),
    CategoryModel(
      image: AppAssets.scienceCategory,
      name: 'Science',
    ),
    CategoryModel(
      image: AppAssets.otherCategory,
      name: 'Other',
    ),
  ];

  final bool isViewedByItsInstructor;
  final bool isSubscribed;

  CourseDetailsView({
    super.key,
    required this.course,
    required this.isSubscribed,
    this.isViewedByItsInstructor = false,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Container(),
            expandedHeight: screenSize.height * .25,
            flexibleSpace: FlexibleSpaceBar(
              background: course.picture != null
                  ? Image.network(
                      width: double.infinity,
                      fit: BoxFit.cover,
                      course.picture!,
                    )
                  : Image.asset(
                      width: double.infinity,
                      fit: BoxFit.cover,
                      AppAssets.courseImageDefault,
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              course.title ?? '',
                              style: AppStyles.style20,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "( ${course.category} )",
                              style: AppStyles.style13Grey,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppConstance.primaryColor,
                          ),
                        ),
                        child: Text(
                          "${course.price}\$",
                          style: AppStyles.style22,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "video_intro".tr,
                    style: AppStyles.style17,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (course.videoIntroduction != null &&
                      course.videoIntroduction != '')
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CustomVideoPlayer(
                            videoUrl: course.videoIntroduction!,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  Text(
                    "what_will_you_learn".tr,
                    style: AppStyles.style17,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black26,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ReadMoreText(
                      course.description ?? '',
                      trimLines: 1,
                      style: AppStyles.style15Grey,
                      colorClickableText: AppConstance.primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    '${'number_of_lectures'.tr} : ${course.lecturesCount}',
                    style: AppStyles.style13Grey,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  if (course.instructorDetails != null)
                    InstructorDetailsItem(
                      instructor: course.instructorDetails!,
                      // instructorId: course.instructorId ?? '',
                    ),
                  SizedBox(
                    height: 25,
                  ),
                  if (isSubscribed)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'lectures'.tr,
                              style: AppStyles.style17,
                            ),
                            CustomTextButton(
                              title: "show_all".tr,
                              onPressed: () async {
                                navigate(
                                    context: context,
                                    screen: CourseLecturesView(
                                      courseId: course.id ?? '',
                                      instructor: course.instructorDetails,
                                    ));
                                await context
                                    .read<CourseLecturesCubit>()
                                    .getCourseLectures(course.id ?? '');
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  if (!isViewedByItsInstructor)
                    BlocConsumer<CourseDetailsCubit, CourseDetailsStates>(
                      listener: (context, state) async {
                        if (state is GetCouponDataErrorState) {
                          showSnackBar(
                            context: context,
                            label: CacheHelper.isAr != false
                                ? await translateEnglishToArabic(state.error)
                                : state.error,
                            color: AppConstance.warningColor,
                          );
                        }
                      },
                      builder: (context, state) {
                        var cubit = context.read<CourseDetailsCubit>();
                        return ExpansionTile(
                          childrenPadding: EdgeInsets.all(10),
                          title: Text(
                            'use_coupon'.tr,
                            style: AppStyles.style17,
                          ),
                          children: [
                            Column(
                              children: [
                                CustomTextFormField(
                                  title: 'coupon_code'.tr,
                                  maxLine: 5,
                                  controller: cubit.couponCodeController,
                                ),
                                state is GetCouponDataLoadingState
                                    ? CustomCircularProgressIndicator()
                                    : Column(
                                        children: [
                                          CustomTextButton(
                                            title: 'check_coupon'.tr,
                                            onPressed: () {
                                              cubit.getCouponData(
                                                  course.id ?? '');
                                            },
                                          ),
                                          if (cubit.couponData != null)
                                            Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${'you_will_get_discount'.tr} ${cubit.couponData!.discountPercentage}%',
                                                  style: AppStyles.style13,
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  SizedBox(
                    height: 30,
                  ),
                  if (!isViewedByItsInstructor)
                    BlocConsumer<CourseDetailsCubit, CourseDetailsStates>(
                      listener: (context, state) async {
                        if (state is PayForCourseSuccessState) {
                          navigateAndRemoveUntil(
                              context: context, screen: LayoutView());
                          showSnackBar(
                              context: context,
                              label: 'course_payed_success'.tr,
                              color: AppConstance.primaryColor);
                          await context.read<HomeCubit>().getCourses();
                          await context
                              .read<EnrolledCoursesCubit>()
                              .getEnrolledCourses();
                        }
                      },
                      builder: (context, state) {
                        var cubit = context.read<CourseDetailsCubit>();
                        if (state is PayForCourseLoadingState) {
                          return CustomCircularProgressIndicator();
                        }
                        return CustomButton(
                          backgroundColor: AppConstance.primaryColor,
                          title: 'buy_course'.tr,
                          onPressed: () async {
                            await cubit.payForCourse(
                              course.id ?? '',
                            );
                          },
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
