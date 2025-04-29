import 'package:dio/dio.dart';
import 'package:e_learning/features/favourites/domain/use_cases/add_to_favourites_use_case.dart';
import 'package:e_learning/features/favourites/domain/use_cases/get_all_favourites_use_case.dart';
import 'package:e_learning/features/favourites/domain/use_cases/remove_from_favourites_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/failure/failure.dart';
import '../../../home/data/models/get_courses_response_model.dart';
import 'favourites_states.dart';

class FavouritesCubit extends Cubit<FavouritesState> {

  final AddToFavouritesUseCase addToFavouritesUseCase;
  final RemoveFromFavouritesUseCase removeFromFavouritesUseCase;
  final GetAllFavouritesUseCase getAllFavouritesUseCase;

  List<CourseResponseModel> favourites = [];
  List<String> favouritesIds = [];


  FavouritesCubit(
      this.getAllFavouritesUseCase,
      this.removeFromFavouritesUseCase,
      this.addToFavouritesUseCase,
      ) : super(FavouritesInitialState());

  Future<void> addToFavourites(String courseId)async{
    favouritesIds.add(courseId);
    await addToFavouritesUseCase.execute(courseId);
    emit(AddToFavouritesState());
  }

  Future<void> removeFromFavourites(String courseId)async{
    favouritesIds.remove(courseId);
    await removeFromFavouritesUseCase.execute(courseId);
    emit(RemoveFromFavouritesState());
  }

  Future<void> changeFavourites(String courseId)async{
    if(favouritesIds.contains(courseId)){
      await removeFromFavourites(courseId);
    }
    else{
      await addToFavourites(courseId);
    }
    await getAllFavourites();
  }

  Future<void> getAllFavourites()async{
    emit(FavouritesLoadingState());
    try{
      favourites = await getAllFavouritesUseCase.execute();
      for(var course in favourites){
        favouritesIds.add(course.id ?? '');
      }
      emit(FavouritesSuccessState());
    }
    catch(error){
      if (error is DioException) {
        emit(FavouritesErrorState(ServerFailure.fromDioException(error).error));
      } else {
        emit(FavouritesErrorState(error.toString()));
      }
    }
  }

}
