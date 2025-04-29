import 'package:e_learning/features/favourites/domain/repos/favourites_repo.dart';

class AddToFavouritesUseCase {
  final FavouritesRepo favouritesRepo;

  AddToFavouritesUseCase(this.favouritesRepo);

  Future<void>execute(String courseId)async{
    await favouritesRepo.addToFavourites(courseId);
  }

}