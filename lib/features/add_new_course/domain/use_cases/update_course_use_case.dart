import 'package:e_learning/features/add_new_course/domain/repos/add_new_course_repo.dart';

class UpdateCourseUseCase {
  final AddNewCourseRepo addNewCourseRepo;

  UpdateCourseUseCase(this.addNewCourseRepo);

  Future<void> execute(dynamic data) async {
    await addNewCourseRepo.updateCourse(
        data
    );
  }
}
