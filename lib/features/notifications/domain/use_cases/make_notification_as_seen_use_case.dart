import 'package:e_learning/features/notifications/domain/repos/notifications_repo.dart';

class MakeNotificationAsSeenUseCase {
  final NotificationsRepo notificationsRepo;
  MakeNotificationAsSeenUseCase(this.notificationsRepo);

  Future<void> execute(String notificationId)async{
    await notificationsRepo.makeNotificationAsSeen(notificationId);
  }
}