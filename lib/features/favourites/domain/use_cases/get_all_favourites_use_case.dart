import 'package:e_learning/features/favourites/domain/repos/favourites_repo.dart';

import '../../../home/data/models/get_courses_response_model.dart';

class GetAllFavouritesUseCase {

  final FavouritesRepo favouritesRepo;

  GetAllFavouritesUseCase(this.favouritesRepo);

  Future<List<CourseResponseModel>> execute()async{
    var res = await favouritesRepo.getAllFavourites();
    List<CourseResponseModel> favourites = [];
    for(var favourite in res){
      favourites.add(CourseResponseModel.fromJson(favourite));
    }
    return favourites;
  }
}