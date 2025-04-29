import 'dart:io';
import 'package:dio/dio.dart'  as dio;
import 'package:e_learning/features/add_new_course/domain/use_cases/add_new_course_use_case.dart';
import 'package:e_learning/features/home/data/models/get_courses_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../home/data/models/category_model.dart';
import '../../domain/use_cases/update_course_use_case.dart';
import 'add_new_course_states.dart';
import 'convert_url_into_xfile_use_case.dart';

class AddNewCourseCubit extends Cubit<AddNewCourseStates> {
  final AddNewCourseUseCase addNewCourseUseCase;
  final UpdateCourseUseCase updateCourseUseCase;
  final ConvertUrlIntoXFileForCourseUseCase convertUrlIntoXFileUseCase;

  AddNewCourseCubit(
    this.addNewCourseUseCase,
      this.updateCourseUseCase,
      this.convertUrlIntoXFileUseCase,
  ) : super(
          AddNewCourseInitialState(),
        );

  static AddNewCourseCubit get(context) =>
      BlocProvider.of<AddNewCourseCubit>(context);

  TextEditingController courseTitleController = TextEditingController();
  TextEditingController courseDescriptionController = TextEditingController();
  TextEditingController coursePriceController = TextEditingController();

  List<CategoryModel> categories = [
    CategoryModel(
      image: AppAssets.programmingCategory,
      name: 'programming'.tr,
    ),
    CategoryModel(
      image: AppAssets.scienceCategory,
      name: 'science'.tr,
    ),
    CategoryModel(
      image: AppAssets.otherCategory,
      name: 'other'.tr,
    ),
  ];

  int selectedCategory = 0;

  selectCategory(index) {
    selectedCategory = index;
    emit(SelectCategoryState());
  }

  XFile? pickedImage;
  XFile? pickedVideo;
  VideoPlayerController? videoPlayedController;
  final picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImage = XFile(pickedFile.path);
      emit(SelectImageSuccessfully());
    } else {
      emit(NoImageSelectedState());
    }
  }

  Future<void> pickVideoFromGallery() async {
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      pickedVideo = video;
      videoPlayedController = VideoPlayerController.file(File(pickedVideo!.path));
      videoPlayedController!.initialize();
      videoPlayedController!.play();
      emit(SelectVideoSuccessfully());
    } else {
      emit(NoVideoSelectedState());
    }
  }

  Future<void> addNewCourse() async {
    emit(AddNewCourseLoadingState());
    try{
      dio.FormData data = dio.FormData.fromMap({
        "category" : categories[selectedCategory].name,
        "coursePicture" :pickedImage != null ?
        await dio.MultipartFile.fromFile(
            pickedImage!.path,
            contentType: MediaType("image","png")
        ) : "",
        "courseOverview" : pickedVideo != null ?
        await dio.MultipartFile.fromFile(
            pickedVideo!.path,
            contentType: MediaType("video","mp4")
        ) : "",
        "description" : courseDescriptionController.text,
        "price" : coursePriceController.text,
        "title" : courseTitleController.text,
      });
      await addNewCourseUseCase.execute(data);
      emit(AddNewCourseSuccessfullyState());
    }
    catch(e){
      if (e is dio.DioException) {
        emit(AddNewCourseErrorState(ServerFailure.fromDioException(e).error));
      } else {
        emit(AddNewCourseErrorState(e.toString()));
      }
    }

  }

  Future<void> updateCourse(String courseId) async {
    emit(AddNewCourseLoadingState());
    try{
      dio.FormData data = dio.FormData.fromMap({
        "courseId" : courseId,
        "category" : categories[selectedCategory].name,
        "coursePicture" :pickedImage != null ?
        await dio.MultipartFile.fromFile(
            pickedImage!.path,
            contentType: MediaType("image","png")
        ) : "",
        "courseOverview" : pickedVideo != null ?
        await dio.MultipartFile.fromFile(
            pickedVideo!.path,
            contentType: MediaType("video","mp4")
        ) : "",
        "description" : courseDescriptionController.text,
        "price" : coursePriceController.text,
        "title" : courseTitleController.text,
      });
      await updateCourseUseCase.execute(data);
      emit(AddNewCourseSuccessfullyState());
    }
    catch(e){
      if (e is dio.DioException) {
        emit(AddNewCourseErrorState(ServerFailure.fromDioException(e).error));
      } else {
        emit(AddNewCourseErrorState(e.toString()));
      }
    }

  }

  void getCourseCategory(String category){
    if(category =='Programming' || category =='البرمجة'){
      selectedCategory = 0;
      return;
    }
    if(category =='Science' || category =='العلوم'){
      selectedCategory = 1;
      return ;
    }
    else{
      selectedCategory = 2;
    }
  }

  Future<void> fillFieldsWithCourseData(CourseResponseModel course)async{
    emit(PrepareCourseDataLoadingState());
    courseTitleController.text = course.title ?? '';
    courseDescriptionController.text = course.description ?? '';
    coursePriceController.text = course.price?.toString() ?? '';
    getCourseCategory(course.category ?? '');
    if(course.picture != null && course.picture != '') {
      pickedImage = await urlToXFile(course.picture!);
    }
   if(course.videoIntroduction != null && course.videoIntroduction != ''){
     pickedVideo = await urlToXFile(course.videoIntroduction!);
     videoPlayedController = VideoPlayerController.file(File(pickedVideo!.path));
     videoPlayedController!.initialize();
     videoPlayedController!.play();
   }
   emit(PrepareCourseDataSuccessState());
  }

  Future<XFile?> urlToXFile(String url) async {
    try {
     XFile? file = await convertUrlIntoXFileUseCase.execute(url);
     return file;
    } catch (e) {
      emit(AddNewCourseErrorState(e.toString()));
      return null;
    }
  }
}
