import 'package:e_learning/core/methods/navigation.dart';
import 'package:e_learning/core/utils/app_assets.dart';
import 'package:e_learning/core/widgets/custom_icon_button.dart';
import 'package:e_learning/core/widgets/custom_text_button.dart';
import 'package:e_learning/features/add_lecture_to_course/presentation/manager/add_new_lecture_cubit.dart';
import 'package:e_learning/features/add_lecture_to_course/presentation/views/add_new_lecture_view.dart';
import 'package:e_learning/features/add_new_course/presentation/manager/add_new_course_cubit.dart';
import 'package:e_learning/features/add_new_course/presentation/views/add_new_course_view.dart';
import 'package:e_learning/features/course_coupons/presentation/manager/course_coupons_cubit/course_coupons_cubit.dart';
import 'package:e_learning/features/course_coupons/presentation/views/course_coupons_view.dart';
import 'package:e_learning/features/course_details/presentation/views/course_details_view.dart';
import 'package:e_learning/features/create_coupon/presentation/views/create_coupon_view.dart';
import 'package:e_learning/features/home/data/models/get_courses_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/app_dimensions.dart';
import '../../../../../core/utils/app_styles.dart';

class UploadedCourseItem extends StatelessWidget {
  final CourseResponseModel course;
  final void Function()? onPressed;

  const UploadedCourseItem({
    super.key,
    required this.course,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // print(course.id);
    var screenHeight = AppDimensions.screenHeight;
    var screenWidth = AppDimensions.screenWidth;
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: screenWidth * .8,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * .18,
              width: screenWidth * .8,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: screenHeight * .15,
                    width: screenWidth * .8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                        // shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              (course.picture != null && course.picture != '')
                                  ? NetworkImage(
                                      course.picture!,
                                    )
                                  : AssetImage(
                                      AppAssets.courseImageDefault,
                                    ),
                        )),
                  ),
                  Positioned(
                    top: screenHeight * .06,
                    child: Container(
                      height: screenHeight * .15,
                      width: screenWidth * .15,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: (course.instructorDetails != null &&
                                    course.instructorDetails
                                            ?.userProfileImage !=
                                        null &&
                                    course.instructorDetails
                                            ?.userProfileImage !=
                                        '')
                                ? NetworkImage(
                                    course.instructorDetails!.userProfileImage!,
                                  )
                                : AssetImage(AppAssets.userImage),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              course.title ?? '',
              style: AppStyles.style13,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '(${course.category})',
              style: AppStyles.style13Grey,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '4.8',
                  style: AppStyles.style13,
                ),
                Icon(
                  Icons.star_rate,
                  color: Colors.yellow,
                  size: 20,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIconButton(
                  onPressed: () async {
                    await context
                        .read<AddNewCourseCubit>()
                        .fillFieldsWithCourseData(course);
                    navigate(
                        context: context,
                        screen: AddNewCourseView(
                          isEdit: true,
                          courseId: course.id,
                        ));
                  },
                  icon: Icons.edit,
                ),
                CustomIconButton(
                  onPressed: () {
                    context.read<AddNewLectureCubit>().emptyFormFields();
                    navigate(
                        context: context,
                        screen: AddLectureView(
                          courseId: course.id ?? '',
                        ));
                  },
                  icon: Icons.add,
                ),
                CustomIconButton(
                  onPressed: () {
                    navigate(
                        context: context,
                        screen: CourseDetailsView(
                          isSubscribed: true,
                          course: course,
                          couponsAndBuyButtonsAreHidden: true,
                          isReviewedByInstructor: true,
                        ));
                  },
                  icon: Icons.info,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextButton(
                  title: 'create_coupon'.tr,
                  onPressed: () {
                    navigate(
                      context: context,
                      screen: CreateCouponView(courseId: course.id ?? ''),
                    );
                  },
                ),
                CustomTextButton(
                  title: 'course_coupons'.tr,
                  onPressed: () {
                    navigate(
                      context: context,
                      screen: CourseCouponsView(),
                    );
                    context.read<CourseCouponsCubit>().getCourseCoupons(course.id ?? '');
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
