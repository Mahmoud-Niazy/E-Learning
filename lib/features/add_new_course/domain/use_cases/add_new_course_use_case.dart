import 'package:e_learning/features/add_new_course/domain/repos/add_new_course_repo.dart';

class AddNewCourseUseCase {
  final AddNewCourseRepo addNewCourseRepo;

  AddNewCourseUseCase(this.addNewCourseRepo);

  Future<void> execute(dynamic data) async {
    await addNewCourseRepo.addNewCourse(
     data
    );
  }
}
