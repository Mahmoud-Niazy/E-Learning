import 'package:e_learning/features/notifications/data/models/notification_model/notifications_model.dart';
import 'package:e_learning/features/notifications/domain/repos/notifications_repo.dart';

class GetAllNotificationsUseCase {
  final NotificationsRepo notificationsRepo;

  GetAllNotificationsUseCase(this.notificationsRepo);

  Future<List<NotificationModel>> execute()async{
    List<NotificationModel> notifications = [];
    var res = await notificationsRepo.getAllNotifications();
    for(var notification in res){
      notifications.add(NotificationModel.fromJson(notification));
    }
    return notifications;
  }

}