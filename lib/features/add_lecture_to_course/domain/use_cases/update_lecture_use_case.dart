import '../repos/add_new_lecture_repo.dart';

class UpdateLectureUseCase {
  final AddNewLectureRepo addNewLectureRepo;

  UpdateLectureUseCase(this.addNewLectureRepo);

  Future<void> execute(dynamic data) async {
    await addNewLectureRepo.updateLecture(
        data
    );
  }
}
