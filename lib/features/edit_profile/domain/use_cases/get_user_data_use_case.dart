
import 'package:e_learning/features/edit_profile/domain/repos/edit_profile_repo.dart';

import '../../../home/data/models/user_data_model.dart';

class GetUserDataForEditUseCase {
  final EditProfileRepo homeRepo;

  GetUserDataForEditUseCase(this.homeRepo);

  Future<UserData> execute() async {
    var res = await homeRepo.getUserData();
    UserData user = UserData.fromJson(res);
    return user;
  }
}
