import 'package:e_learning/features/home/data/models/user_data_model.dart';
import 'package:e_learning/features/home/domain/repos/home_repo.dart';

class GetUserDataUseCase {
  final HomeRepo homeRepo;
  GetUserDataUseCase(this.homeRepo);

  Future<UserData> execute()async{
    var res = await homeRepo.getUserData();
    UserData user = UserData.fromJson(res);
    return user;
  }
}