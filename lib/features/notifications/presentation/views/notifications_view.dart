import 'package:e_learning/core/utils/app_styles.dart';
import 'package:e_learning/core/widgets/custom_circular_progress_indicator.dart';
import 'package:e_learning/core/widgets/empty_list_widget.dart';
import 'package:e_learning/features/notifications/presentation/manager/notifications_cubit/notifications_cubit.dart';
import 'package:e_learning/features/notifications/presentation/manager/notifications_cubit/notifications_states.dart';
import 'package:e_learning/features/notifications/presentation/views/widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatelessWidget {

  const NotificationScreen({super.key});

  String formatTimestamp(DateTime time) {
    return DateFormat('MMM d, h:mm a').format(time);
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<NotificationsCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "notifications".tr,
          style: AppStyles.style17,
        ),
        elevation: 0,
        centerTitle: false,
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsStates>(
        builder: (context, state) {
          if(state is GetAllNotificationsLoadingState){
            return CustomCircularProgressIndicator();
          }
          if(cubit.notifications.isEmpty){
            return EmptyListWidget();
          }
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: cubit.notifications.length,
            itemBuilder: (context, index) {
              final notification = cubit.notifications[index];
              return NotificationItem(notification: notification);
            },
          );
        },
      ),
    );
  }
}


