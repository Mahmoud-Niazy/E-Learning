import 'package:e_learning/features/notifications/domain/repos/notifications_repo.dart';

class MakeAllNotificationsAsSeenUseCase {
  final NotificationsRepo notificationsRepo;
  MakeAllNotificationsAsSeenUseCase(this.notificationsRepo);

  Future<void> execute()async{
    await notificationsRepo.makeAllNotificationsAsSeen();
  }
}