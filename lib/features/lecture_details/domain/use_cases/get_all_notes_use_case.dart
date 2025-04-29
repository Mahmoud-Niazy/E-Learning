import 'package:e_learning/features/lecture_details/data/models/note_model/note_model.dart';
import 'package:e_learning/features/lecture_details/domain/repos/lecture_details_repo.dart';

class GetAllNotesUseCase {
  final LectureDetailsRepo lectureDetailsRepo;

  GetAllNotesUseCase(
    this.lectureDetailsRepo,
  );

  Future<List<NoteModel>> execute(String lectureId)async{
    var res = await lectureDetailsRepo.getAllNotes(lectureId);
    List<NoteModel> notes = [];
    if(res.isEmpty){
      return [];
    }
    for(var note in res){
      notes.add(NoteModel.fromJson(note));
    }
    return notes;
  }
}
