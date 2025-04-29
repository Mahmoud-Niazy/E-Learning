import 'package:e_learning/features/auth/data/models/user_registration_response_model.dart';
import 'package:e_learning/features/auth/domain/repos/auth_repo.dart';

class SignInUseCase {
  final AuthRepo authRepo;

  SignInUseCase(this.authRepo);

  Future<UserRegistrationResponseDataModel> execute({
    required String email,
    required String password,
})async{
    var res = await authRepo.signIn(email: email, password: password);
    UserRegistrationResponseDataModel userRegistrationResponseDataModel = UserRegistrationResponseDataModel.fromJson(res);
    return userRegistrationResponseDataModel;
  }
}