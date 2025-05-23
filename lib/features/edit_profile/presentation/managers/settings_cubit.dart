import 'package:dio/dio.dart';
import 'package:e_learning/features/edit_profile/presentation/managers/settings_state.dart';
import 'package:e_learning/features/home/data/models/user_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/failure/failure.dart';
import '../../domain/use_cases/get_user_data_use_case.dart';
import '../../domain/use_cases/pick_image_use_case.dart';
import '../../domain/use_cases/update_user_data_use_case.dart';

class EditProfileCubit extends Cubit<EditProfileStates> {

  final GetUserDataForEditUseCase getUserDataUseCase;
  final UpdateUserDataUseCase updateUserDataUseCase;
  final PickImageForEditUseCase pickImageUseCase;

  EditProfileCubit(
     this.getUserDataUseCase,
     this.updateUserDataUseCase,
     this.pickImageUseCase,
  ) : super(EditProfileInitialState());

  static EditProfileCubit get(context) => BlocProvider.of<EditProfileCubit>(context);
  String userImageUrl = '';

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  UserData? currentUser;

  Future<void> getUserData() async {
    emit(GetUserDataLoadingState());
    try {
      currentUser = await getUserDataUseCase.execute();
      fillFormFieldsByUserData(currentUser!);
      emit(GetUserDataSuccessfullyState());
    } catch (error) {
      if (error is DioException) {
        emit(GetUserDataErrorState(ServerFailure.fromDioException(error).error));
      } else {
        emit(GetUserDataErrorState(error.toString()));
      }
    }
  }

  fillFormFieldsByUserData(UserData userData){
    userImage = null;
    emailController.text = userData.email;
    phoneController.text = userData.phone;
    nameController.text = userData.name;
    currentPasswordController.text = '';
    newPasswordController.text = '';
    userImageUrl = userData.image;
  }



  updateUserData() async {
    emit(UpdateUserDataLoadingState());
    try{
      FormData formData = FormData.fromMap({
        'profilePicture': userImage != null ?
        await MultipartFile.fromFile(
          userImage!.path,
            contentType: MediaType("image","png")
        ) : "",
        "currentPassword" : currentPasswordController.text,
        "email" : emailController.text,
        "name" : nameController.text,
        "newPassword" : newPasswordController.text,
        "phone" :  phoneController.text,
      });

      await updateUserDataUseCase.execute(
        data: formData,
      );

      await getUserData();
      emit(UpdateUserDataSuccessfullyState());
    }
    catch(error){
      if (error is DioException) {
        emit(UpdateUserDataErrorState(
            ServerFailure.fromDioException(error).error));
      } else {
        emit(UpdateUserDataErrorState(error.toString()));
      }
    }
  }

  XFile? userImage ;
  Future<void> pickImage()async{
     userImage = await pickImageUseCase.execute();
    if(userImage == null){
      emit(NoImageSelectedState());
    }
    else{
      emit(ImageSelectedSuccessfullyState());
    }
  }


}
