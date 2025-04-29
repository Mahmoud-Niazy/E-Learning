abstract class FavouritesRepo {
  Future<void> addToFavourites(String courseId);
  Future<void> removeFromFavourites(String courseId);

  Future<List<Map<String,dynamic>>> getAllFavourites();
}