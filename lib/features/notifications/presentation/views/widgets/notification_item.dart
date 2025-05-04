import 'package:e_learning/core/methods/format_date.dart';
import 'package:e_learning/core/methods/navigation.dart';
import 'package:e_learning/core/utils/app_constance.dart';
import 'package:e_learning/core/utils/app_styles.dart';
import 'package:e_learning/features/lectures_of_course/presentation/manager/course_lectures_cubit/course_lectures_cubit.dart';
import 'package:e_learning/features/lectures_of_course/presentation/views/course_lectures_view.dart';
import 'package:e_learning/features/notifications/data/models/notification_model/notifications_model.dart';
import 'package:e_learning/features/user_uploaded_courses/presentation/views/user_uploaded_courses_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  const NotificationItem({
    super.key,
    required this.notification,
  });

  IconData getNotificationIcon() {
    if (notification.type == 'course_purchased') {
      return Icons.payment_outlined;
    }
    return Icons.star_border;
  }

  String getNotificationSubTitle() {
    if (notification.type == 'course_purchased') {
      return "${'your_course_titled'.tr} ${notification.course!.title} ${'has_been_purchased'.tr}";
    }
    return "${'new_lecture_titled'.tr} ${notification.lecture!.title} ${'has_been_added'.tr} ${notification.course!.title}";
  }

  String getNotificationTitle() {
    if (notification.type == 'course_purchased') {
      return "new_purchase".tr;
    }
    return 'new_lecture'.tr;
  }

  void onPressOnNotification(BuildContext context) {
    if (notification.type == 'course_purchased') {
      navigate(
        context: context,
        screen: UserUploadedCoursesView(),
      );
    } else {
      navigate(
        context: context,
        screen: CourseLecturesView(
          courseId: notification.course!.id ?? '',
          instructor: null,
        ),
      );
      context.read<CourseLecturesCubit>().getCourseLectures(notification.course!.id ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onPressOnNotification(context);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(16),
          leading: CircleAvatar(
            backgroundColor: AppConstance.primaryColor,
            child: Icon(getNotificationIcon(), color: Colors.white),
          ),
          title: Text(getNotificationTitle(), style: AppStyles.style13),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getNotificationSubTitle(),
                style: AppStyles.style13.copyWith(color: Colors.black26),
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDateWithTime(notification.createdAt!),
                    style: AppStyles.style11.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  if (notification.seen == false)
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
