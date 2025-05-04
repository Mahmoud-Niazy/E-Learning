import 'package:e_learning/core/api/api_services.dart';
import 'package:e_learning/core/cache_helper/cache_helper.dart';

import '../../domain/repos/notifications_repo.dart';

class NotificationsRepoImp extends NotificationsRepo {
  final ApiServices apiServices;

  NotificationsRepoImp(this.apiServices);

  @override
  Future<List<Map<String,dynamic>>> getAllNotifications() async {
    var res = await apiServices.getData(
      path: 'notifications',
      token: CacheHelper.token,
    );

    return res['notifications'].cast<Map<String,dynamic>>();
  }
}
