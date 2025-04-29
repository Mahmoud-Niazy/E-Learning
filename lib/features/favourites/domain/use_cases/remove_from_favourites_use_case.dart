import '../repos/favourites_repo.dart';

class RemoveFromFavouritesUseCase {

  final FavouritesRepo favouritesRepo;

  RemoveFromFavouritesUseCase(this.favouritesRepo);

  Future<void> execute(String courseId)async{
    await favouritesRepo.removeFromFavourites(courseId);
  }
}