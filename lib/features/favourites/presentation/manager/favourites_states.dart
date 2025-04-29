abstract class FavouritesState{}

class FavouritesInitialState extends FavouritesState{}

class FavouritesLoadingState extends FavouritesState{}
class FavouritesSuccessState extends FavouritesState{}
class FavouritesErrorState extends FavouritesState{
  final String error ;
  FavouritesErrorState(this.error);
}

class FavouritesProcessState extends FavouritesState{}

class AddToFavouritesState extends FavouritesState{}
class RemoveFromFavouritesState extends FavouritesState{}




