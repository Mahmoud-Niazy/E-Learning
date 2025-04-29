import '../repos/add_new_lecture_repo.dart';

class AddNewLectureUseCase {
  final AddNewLectureRepo addNewLectureRepo;

  AddNewLectureUseCase(this.addNewLectureRepo);

  Future<void> execute(dynamic data) async {
    await addNewLectureRepo.addNewLecture(
     data
    );
  }
}
