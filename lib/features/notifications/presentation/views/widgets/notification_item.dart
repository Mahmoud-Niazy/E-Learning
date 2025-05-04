import 'package:e_learning/core/methods/format_date.dart';
import 'package:e_learning/core/utils/app_constance.dart';
import 'package:e_learning/core/utils/app_styles.dart';
import 'package:e_learning/features/notifications/data/models/notification_model/notifications_model.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
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
                style : AppStyles.style13.copyWith(
                  color: Colors.black26
                ),
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              formatDateWithTime(notification.createdAt!),
              style: AppStyles.style11.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
