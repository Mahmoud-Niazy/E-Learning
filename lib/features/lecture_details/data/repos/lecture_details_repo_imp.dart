import 'package:e_learning/core/api/api_services.dart';
import 'package:e_learning/core/cache_helper/cache_helper.dart';
import 'package:e_learning/features/lecture_details/domain/repos/lecture_details_repo.dart';

class LectureDetailsRepoImp extends LectureDetailsRepo {
  final ApiServices apiServices;

  LectureDetailsRepoImp(this.apiServices);

  @override
  Future<void> addNote({
    required String note,
    required String lectureId,
    required String videoSeconds,
  }) async {
    await apiServices.postData(
      path: '/notes',
      data: {
        "note": note,
        "lectureId": lectureId,
        "videoSeconds": videoSeconds,
      },
      token: CacheHelper.token,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getAllNotes(String lectureId) async {
    var res = await apiServices.getData(
      path: '/notes/get-lecture-notes/$lectureId',
      token: CacheHelper.token,
    );
    return res['notes'].cast<Map<String,dynamic>>();
  }
}
