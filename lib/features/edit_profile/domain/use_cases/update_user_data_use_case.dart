import 'package:e_learning/features/edit_profile/domain/repos/edit_profile_repo.dart';

class UpdateUserDataUseCase {
  final EditProfileRepo settingsRepo;

  UpdateUserDataUseCase(this.settingsRepo);

  Future<void> execute({
    required dynamic data
}) async {
    await settingsRepo.updateUserData(
     data: data,
    );
  }
}
