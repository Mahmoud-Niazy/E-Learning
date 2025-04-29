import 'package:e_learning/core/utils/app_assets.dart';
import 'package:e_learning/core/utils/app_constance.dart';
import 'package:e_learning/core/utils/app_dimensions.dart';
import 'package:e_learning/core/widgets/custom_icon_button.dart';
import 'package:e_learning/features/favourites/presentation/manager/favourites_cubit.dart';
import 'package:e_learning/features/favourites/presentation/manager/favourites_states.dart';
import 'package:e_learning/features/home/data/models/get_courses_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_styles.dart';

class CourseItem extends StatelessWidget {
  final CourseResponseModel course;
  final void Function()? onPressed;

  const CourseItem({
    super.key,
    required this.course,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    var screenHeight = AppDimensions.screenHeight;
    var screenWidth = AppDimensions.screenWidth;
    return InkWell(
        onTap: onPressed,
    child: Container(
        width: screenWidth  * .8,
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Column(
          children: [
           SizedBox (
              height: screenHeight * .18,
              width: screenWidth * .8,
              child: Stack(
               alignment: Alignment.topCenter,
                children: [
                  Stack(
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
                              image:  (course.picture != null && course.picture != '')
                                  ? NetworkImage(
                                course.picture!,

                              )
                                  : AssetImage(
                                AppAssets.courseImageDefault,
                              ),
                            )
                        ),
                      ),
                      BlocBuilder<FavouritesCubit, FavouritesState>(
                        builder: (context, state) {
                          var cubit = context.read<FavouritesCubit>();
                          return Container(
                            height: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: CustomIconButton(
                              onPressed: () {
                                cubit.changeFavourites(course.id ?? '');
                              },
                              size: 18,
                              icon: Icons.bookmark,
                              color: cubit.favouritesIds.contains(course.id) ? AppConstance.primaryColor : Colors.black45 ,
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  Positioned(
                    top: screenHeight * .06,
                    child: Container(
                      height: screenHeight * .15,
                      width: screenWidth * .15,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                          image: DecorationImage(
                              image: (course.instructorDetails != null &&
                                  course.instructorDetails?.userProfileImage != null &&
                                  course.instructorDetails?.userProfileImage != '') ?
                              NetworkImage(course.instructorDetails!.userProfileImage!,)
                                  :
                              AssetImage(AppAssets.userImage),

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
          ],
        ),
      ),
    );
  }
}
