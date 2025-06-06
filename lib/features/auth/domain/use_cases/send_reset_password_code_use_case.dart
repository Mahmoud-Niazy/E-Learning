import 'package:e_learning/features/auth/domain/repos/auth_repo.dart';

class SendResetPasswordCodeUseCase {
  final AuthRepo authRepo;

  SendResetPasswordCodeUseCase(this.authRepo);

  Future<void> execute(String email)async{
    await authRepo.sendResetPasswordCode(email);
  }
}