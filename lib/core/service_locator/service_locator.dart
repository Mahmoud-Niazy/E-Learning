import 'package:e_learning/core/scocket_io_services/socket_services.dart';
import 'package:e_learning/core/widgets/video_player/manager/video_player_cubit/video_player_cubit.dart';
import 'package:e_learning/features/add_lecture_to_course/presentation/manager/add_new_lecture_cubit.dart';
import 'package:e_learning/features/add_new_course/data/repos/add_new_course_repo_imp.dart';
import 'package:e_learning/features/add_new_course/domain/use_cases/add_new_course_use_case.dart';
import 'package:e_learning/features/add_new_course/domain/use_cases/update_course_use_case.dart';
import 'package:e_learning/features/add_new_course/presentation/manager/add_new_course_cubit.dart';
import 'package:e_learning/features/add_new_course/presentation/manager/convert_url_into_xfile_use_case.dart';
import 'package:e_learning/features/auth/domain/repos/auth_repo.dart';
import 'package:e_learning/features/auth/data/repos/user_repo_imp.dart';
import 'package:e_learning/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:e_learning/features/auth/domain/use_cases/send_reset_password_code_use_case.dart';
import 'package:e_learning/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:e_learning/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:e_learning/features/chat/domain/repos/chat_repo.dart';
import 'package:e_learning/features/chat/domain/use_cases/get_conversations_use_case.dart';
import 'package:e_learning/features/chat/domain/use_cases/get_messages_use_case.dart';
import 'package:e_learning/features/chat/domain/use_cases/send_message_use_case.dart';
import 'package:e_learning/features/chat/presentation/manager/chat_cubit.dart';
import 'package:e_learning/features/course_coupons/domain/repos/course_coupons_repo.dart';
import 'package:e_learning/features/course_coupons/domain/use_cases/delete_coupon_use_case.dart';
import 'package:e_learning/features/course_coupons/domain/use_cases/get_course_coupons_use_case.dart';
import 'package:e_learning/features/course_coupons/presentation/manager/course_coupons_cubit/course_coupons_cubit.dart';
import 'package:e_learning/features/course_details/domain/repos/course_details_repo.dart';
import 'package:e_learning/features/course_details/domain/use_cases/get_coupon_data_use_case.dart';
import 'package:e_learning/features/course_details/domain/use_cases/pay_for_course_use_case.dart';
import 'package:e_learning/features/course_details/presentation/manager/course_details_cubit/course_details_cubit.dart';
import 'package:e_learning/features/create_coupon/domain/repos/create_coupon_repo.dart';
import 'package:e_learning/features/create_coupon/domain/use_cases/create_coupon_use_case.dart';
import 'package:e_learning/features/create_coupon/presentation/manager/create_coupon_cubit/create_coupon_cubit.dart';
import 'package:e_learning/features/edit_profile/domain/use_cases/get_user_data_use_case.dart';
import 'package:e_learning/features/edit_profile/domain/use_cases/pick_image_use_case.dart';
import 'package:e_learning/features/edit_profile/presentation/managers/settings_cubit.dart';
import 'package:e_learning/features/enrolled_courses/domain/use_cases/get_enrolled_courses_use_case.dart';
import 'package:e_learning/features/enrolled_courses/presentation/manager/enrolled_courses_cubit/enrolled_courses_cubit.dart';
import 'package:e_learning/features/favourites/domain/repos/favourites_repo.dart';
import 'package:e_learning/features/favourites/data/repos/favourites_repo_imp.dart';
import 'package:e_learning/features/favourites/domain/use_cases/add_to_favourites_use_case.dart';
import 'package:e_learning/features/favourites/domain/use_cases/get_all_favourites_use_case.dart';
import 'package:e_learning/features/favourites/domain/use_cases/remove_from_favourites_use_case.dart';
import 'package:e_learning/features/favourites/presentation/manager/favourites_cubit.dart';
import 'package:e_learning/features/home/data/repos/home_repo_imp.dart';
import 'package:e_learning/features/home/domain/use_cases/get_all_courses_use_case.dart';
import 'package:e_learning/features/home/domain/use_cases/get_user_data_use_case.dart';
import 'package:e_learning/features/layout/presentation/manager/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import 'package:e_learning/features/lecture_details/domain/use_cases/add_note_use_case.dart';
import 'package:e_learning/features/lecture_details/domain/use_cases/get_all_notes_use_case.dart';
import 'package:e_learning/features/lecture_details/presentation/manager/lecture_details_cubit/lecture_details_cubit.dart';
import 'package:e_learning/features/lectures_of_course/domain/use_cases/get_course_lectures_use_case.dart';
import 'package:e_learning/features/lectures_of_course/presentation/manager/course_lectures_cubit/course_lectures_cubit.dart';
import 'package:e_learning/features/notifications/domain/repos/notifications_repo.dart';
import 'package:e_learning/features/notifications/domain/use_cases/get_all_notifications_use_case.dart';
import 'package:e_learning/features/notifications/domain/use_cases/make_all_notifications_as_seen_use_case.dart';
import 'package:e_learning/features/notifications/domain/use_cases/make_notification_as_seen_use_case.dart';
import 'package:e_learning/features/notifications/presentation/manager/notifications_cubit/notifications_cubit.dart';
import 'package:e_learning/features/on_boarding/presentation/manager/page_indicator_cubit/page_indicator_cubit.dart';
import 'package:e_learning/features/search/domain/repos/search_repo.dart';
import 'package:e_learning/features/search/presentation/manager/search_cubit.dart';
import 'package:e_learning/features/user_uploaded_courses/data/repos/user_uploaded_courses_repo_imp.dart';
import 'package:e_learning/features/user_uploaded_courses/domain/use_cases/get_user_uploaded_courses_use_case.dart';
import 'package:e_learning/features/user_uploaded_courses/presentation/manager/uploaded_courses_cubit/user_uploaded_courses_cubit.dart';
import 'package:get_it/get_it.dart';
import '../../features/add_lecture_to_course/data/repos/add_new_lecture_repo_imp.dart';
import '../../features/add_lecture_to_course/domain/repos/add_new_lecture_repo.dart';
import '../../features/add_lecture_to_course/domain/use_cases/add_new_lecture_use_case.dart';
import '../../features/add_lecture_to_course/domain/use_cases/update_lecture_use_case.dart';
import '../../features/add_lecture_to_course/presentation/manager/convert_url_into_xfile_use_case.dart';
import '../../features/add_new_course/domain/repos/add_new_course_repo.dart';
import '../../features/chat/data/repos/chat_repo_imp.dart';
import '../../features/course_coupons/data/repos/course_coupons_repo_imp.dart';
import '../../features/course_details/data/repos/course_details_repo_imp.dart';
import '../../features/create_coupon/data/repos/create_coupon_repo_imp.dart';
import '../../features/edit_profile/data/repos/edit_profile_repo_imp.dart';
import '../../features/edit_profile/domain/repos/edit_profile_repo.dart';
import '../../features/edit_profile/domain/use_cases/update_user_data_use_case.dart';
import '../../features/enrolled_courses/data/repos/enrolled_courses_repo_imp.dart';
import '../../features/enrolled_courses/domain/repos/enrolled_courses_repo.dart';
import '../../features/home/domain/repos/home_repo.dart';
import '../../features/home/presentation/manager/home_cubit/home_cubit.dart';
import '../../features/lecture_details/data/repos/lecture_details_repo_imp.dart';
import '../../features/lecture_details/domain/repos/lecture_details_repo.dart';
import '../../features/lectures_of_course/data/repos/course_lectures_repo_imp.dart';
import '../../features/lectures_of_course/domain/repos/course_lectures_repo.dart';
import '../../features/notifications/data/repos/notifications_repo_imp.dart';
import '../../features/search/data/repos/search_repo_imp.dart';
import '../../features/search/domain/use_cases/get_all_courses_use_case.dart';
import '../../features/user_uploaded_courses/domain/repos/user_uploaded_courses_repo.dart';
import '../api/api_services.dart';

final serviceLocator = GetIt.instance;

class ServiceLocator {

  static void init(){

    ///API SERVICE
    serviceLocator.registerLazySingleton<ApiServices>(
          () => ApiServices(),
    );


    /// SOCKET IO
    serviceLocator.registerLazySingleton<SocketService>(
          () => SocketService(),
    );

    /// REPOS
    serviceLocator.registerLazySingleton<AuthRepo>(
      () => AuthRepoImp(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<HomeRepo>(
        () => HomeRepoImp(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<AddNewCourseRepo>(
        ()=> AddNewCourseRepoImp(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<UserUploadedCoursesRepo>(
          ()=> UserUploadedCoursesRepoImp(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<FavouritesRepo>(
          ()=> FavouritesRepoImp(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<SearchRepo>(
          ()=> SearchRepoImp(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<EditProfileRepo>(
          ()=> EditProfileRepoImp(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<AddNewLectureRepo>(
          ()=> AddNewLectureRepoImp(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<CourseLecturesRepo>(
          ()=> CourseLecturesRepoImp(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<CreateCouponRepo>(
          ()=> CreateCouponRepoImp(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<CourseDetailsRepo>(
          ()=> CourseDetailsRepoImp(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<EnrolledCoursesRepo>(
          ()=> EnrolledCoursesRepoImp(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<CourseCouponsRepo>(
          ()=> CourseCouponsRepoImp(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<LectureDetailsRepo>(
          ()=> LectureDetailsRepoImp(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<ChatRepo>(
          ()=> ChatRepoImp(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<NotificationsRepo>(
          ()=> NotificationsRepoImp(serviceLocator()),
    );

    /// USE CASES
    serviceLocator.registerLazySingleton<SignInUseCase>(
          ()=> SignInUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<SignUpUseCase>(
          ()=> SignUpUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<SendResetPasswordCodeUseCase>(
          ()=> SendResetPasswordCodeUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<ResetPasswordUseCase>(
          ()=> ResetPasswordUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetUserDataUseCase>(
          ()=> GetUserDataUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetAllCoursesUseCase>(
          ()=> GetAllCoursesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<AddNewCourseUseCase>(
          ()=> AddNewCourseUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetAllCoursesForSearchUseCase>(
          ()=> GetAllCoursesForSearchUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<AddToFavouritesUseCase>(
          ()=> AddToFavouritesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<RemoveFromFavouritesUseCase>(
          ()=> RemoveFromFavouritesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetAllFavouritesUseCase>(
          ()=> GetAllFavouritesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetUserUploadedCoursesUseCase>(
          ()=> GetUserUploadedCoursesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetUserDataForEditUseCase>(
          ()=> GetUserDataForEditUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<PickImageForEditUseCase>(
          ()=> PickImageForEditUseCase(),
    );
    serviceLocator.registerLazySingleton<UpdateUserDataUseCase>(
          ()=> UpdateUserDataUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<UpdateCourseUseCase>(
          ()=> UpdateCourseUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<ConvertUrlIntoXFileForCourseUseCase>(
          ()=> ConvertUrlIntoXFileForCourseUseCase(),
    );
    serviceLocator.registerLazySingleton<AddNewLectureUseCase>(
          ()=> AddNewLectureUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<UpdateLectureUseCase>(
          ()=> UpdateLectureUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<ConvertUrlIntoXFileForLectureUseCase>(
          ()=> ConvertUrlIntoXFileForLectureUseCase(),
    );
    serviceLocator.registerLazySingleton<GetCourseLecturesUseCase>(
          ()=> GetCourseLecturesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<CreateCouponUseCase>(
          ()=> CreateCouponUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetCouponDataUseCase>(
          ()=> GetCouponDataUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<PayForCourseUseCase>(
          ()=> PayForCourseUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetEnrolledCoursesUseCase>(
          ()=> GetEnrolledCoursesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetCourseCouponsUseCase>(
          ()=> GetCourseCouponsUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<DeleteCouponUseCase>(
          ()=> DeleteCouponUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<AddNoteUseCase>(
          ()=> AddNoteUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetAllNotesUseCase>(
          ()=> GetAllNotesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<SendMessageUseCase>(
          ()=> SendMessageUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetConversationsUseCase>(
          ()=> GetConversationsUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetMessagesUseCase>(
          ()=> GetMessagesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetAllNotificationsUseCase>(
          ()=> GetAllNotificationsUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<MakeAllNotificationsAsSeenUseCase>(
          ()=> MakeAllNotificationsAsSeenUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<MakeNotificationAsSeenUseCase>(
          ()=> MakeNotificationAsSeenUseCase(serviceLocator()),
    );

    /// CUBIT
    serviceLocator.registerFactory<BottomNavigationBarCubit>(
          ()=> BottomNavigationBarCubit(),
    );
    serviceLocator.registerFactory<PageIndicatorCubit>(
          ()=> PageIndicatorCubit(),
    );
    serviceLocator.registerFactory<AuthCubit>(
          ()=> AuthCubit(serviceLocator(),serviceLocator(),serviceLocator(),serviceLocator()),
    );
    serviceLocator.registerFactory<AddNewCourseCubit>(
        ()=> AddNewCourseCubit(serviceLocator(),serviceLocator(),serviceLocator()),
    );
    serviceLocator.registerFactory<UserUploadedCoursesCubit>(
          ()=> UserUploadedCoursesCubit(serviceLocator(),),
    );
    serviceLocator.registerFactory<FavouritesCubit>(
          ()=> FavouritesCubit(serviceLocator(),serviceLocator(),serviceLocator()),
    );
    serviceLocator.registerFactory<HomeCubit>(
          ()=> HomeCubit(serviceLocator(),serviceLocator()),
    );
    serviceLocator.registerFactory<SearchCubit>(
          ()=> SearchCubit(serviceLocator()),
    );
    serviceLocator.registerFactory<EditProfileCubit>(
          ()=> EditProfileCubit( serviceLocator(),serviceLocator(),serviceLocator()),
    );
    serviceLocator.registerFactory<AddNewLectureCubit>(
          ()=> AddNewLectureCubit( serviceLocator(),serviceLocator(),serviceLocator()),
    );
    serviceLocator.registerFactory<CourseLecturesCubit>(
          ()=> CourseLecturesCubit( serviceLocator()),
    );
    serviceLocator.registerFactory<CreateCouponCubit>(
          ()=> CreateCouponCubit( serviceLocator()),
    );
    serviceLocator.registerFactory<CourseDetailsCubit>(
          ()=> CourseDetailsCubit( serviceLocator(),serviceLocator()),
    );
    serviceLocator.registerFactory<EnrolledCoursesCubit>(
          ()=> EnrolledCoursesCubit( serviceLocator()),
    );
    serviceLocator.registerFactory<CourseCouponsCubit>(
          ()=> CourseCouponsCubit( serviceLocator(),serviceLocator()),
    );
    serviceLocator.registerFactory<VideoPlayerCubit>(
          ()=> VideoPlayerCubit(),
    );
    serviceLocator.registerFactory<LectureDetailsCubit>(
          ()=> LectureDetailsCubit(serviceLocator(),serviceLocator(),),
    );
    serviceLocator.registerFactory<ChatCubit>(
          ()=> ChatCubit(serviceLocator(),serviceLocator(),serviceLocator(),serviceLocator()),
    );
    serviceLocator.registerFactory<NotificationsCubit>(
          ()=> NotificationsCubit(serviceLocator(),serviceLocator(),serviceLocator(),serviceLocator()),
    );
  }
}