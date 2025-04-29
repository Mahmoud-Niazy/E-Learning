abstract class LectureDetailsRepo {
  Future<void> addNote({
    required String note,
    required String lectureId,
    required String videoSeconds,
  });

  Future<List<Map<String,dynamic>>> getAllNotes(String lectureId);

}
