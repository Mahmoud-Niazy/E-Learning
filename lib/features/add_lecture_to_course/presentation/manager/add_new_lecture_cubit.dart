import 'dart:io';
import 'package:dio/dio.dart'  as dio;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/failure/failure.dart';
import '../../../lectures_of_course/data/models/lecture_response_model.dart';
import '../../domain/use_cases/add_new_lecture_use_case.dart';
import '../../domain/use_cases/update_lecture_use_case.dart';
import 'add_new_lecture_states.dart';
import 'convert_url_into_xfile_use_case.dart';

class AddNewLectureCubit extends Cubit<AddNewLectureStates> {
  final AddNewLectureUseCase addNewLectureUseCase;
  final UpdateLectureUseCase updateLectureUseCase;
  final ConvertUrlIntoXFileForLectureUseCase convertUrlIntoXFileUseCase;

  AddNewLectureCubit(
    this.addNewLectureUseCase,
      this.updateLectureUseCase,
      this.convertUrlIntoXFileUseCase,
  ) : super(
          AddNewLectureInitialState(),
        );

  static AddNewLectureCubit get(context) =>
      BlocProvider.of<AddNewLectureCubit>(context);

  TextEditingController lectureTitleController = TextEditingController();
  TextEditingController lectureDescriptionController = TextEditingController();

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

  Future<void> addNewLecture(String courseId) async {
    emit(AddNewLectureLoadingState());
    try{
      dio.FormData data = dio.FormData.fromMap({
        "courseId" : courseId,
        "thumbnail" :pickedImage != null ?
        await dio.MultipartFile.fromFile(
            pickedImage!.path,
            contentType: MediaType("image","png")
        ) : "",
        "video" : pickedVideo != null ?
        await dio.MultipartFile.fromFile(
            pickedVideo!.path,
            contentType: MediaType("video","mp4")
        ) : "",
        "description" : lectureDescriptionController.text,
        "title" : lectureTitleController.text,
      });
      await addNewLectureUseCase.execute(data);
      emit(AddNewLectureSuccessfullyState());
    }
    catch(e){
      if (e is dio.DioException) {
        emit(AddNewLectureErrorState(ServerFailure.fromDioException(e).error));
      } else {
        emit(AddNewLectureErrorState(e.toString()));
      }
    }

  }

  Future<void> updateLecture(String courseId, String lectureId) async {
    emit(AddNewLectureLoadingState());
    try{
      dio.FormData data = dio.FormData.fromMap({
        "lectureId" : lectureId,
        "courseId" : courseId,
        "thumbnail" :pickedImage != null ?
        await dio.MultipartFile.fromFile(
            pickedImage!.path,
            contentType: MediaType("image","png")
        ) : "",
        "video" : pickedVideo != null ?
        await dio.MultipartFile.fromFile(
            pickedVideo!.path,
            contentType: MediaType("video","mp4")
        ) : "",
        "description" : lectureDescriptionController.text,
        "title" : lectureTitleController.text,
      });
      await updateLectureUseCase.execute(data);
      emit(AddNewLectureSuccessfullyState());
    }
    catch(e){
      if (e is dio.DioException) {
        emit(AddNewLectureErrorState(ServerFailure.fromDioException(e).error));
      } else {
        emit(AddNewLectureErrorState(e.toString()));
      }
    }

  }


  Future<void> fillFieldsWithLectureData(LectureResponseModel course)async{
    emit(PrepareLectureDataLoadingState());
    lectureTitleController.text = course.title ?? '';
    lectureDescriptionController.text = course.description ?? '';
    if(course.thumbnailUrl != null && course.thumbnailUrl != '') {
      pickedImage = await urlToXFile(course.thumbnailUrl!);
    }
   if(course.videoUrl != null && course.videoUrl != ''){
     pickedVideo = await urlToXFile(course.videoUrl!);
     videoPlayedController = VideoPlayerController.file(File(pickedVideo!.path));
     videoPlayedController!.initialize();
     videoPlayedController!.play();
   }
   emit(PrepareLectureDataSuccessState());
  }

  Future<XFile?> urlToXFile(String url) async {
    try {
     XFile? file = await convertUrlIntoXFileUseCase.execute(url);
     return file;
    } catch (e) {
      emit(AddNewLectureErrorState(e.toString()));
      return null;
    }
  }

  void emptyFormFields(){
    lectureTitleController.text = '';
    lectureDescriptionController.text = '';
    pickedImage = null;
    pickedVideo = null;
  }

}
