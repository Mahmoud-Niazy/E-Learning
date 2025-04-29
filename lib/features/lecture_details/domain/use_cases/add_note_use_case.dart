import 'package:e_learning/features/lecture_details/domain/repos/lecture_details_repo.dart';

class AddNoteUseCase {
  final LectureDetailsRepo lectureDetailsRepo;

  AddNoteUseCase(this.lectureDetailsRepo);

  Future<void> execute({
    required String note,
    required String lectureId,
    required String videoSeconds,
  }) async {
    await lectureDetailsRepo.addNote(
      note: note,
      lectureId: lectureId,
      videoSeconds: videoSeconds,
    );
  }
}
