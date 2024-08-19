part of 'favourite_bloc.dart';

sealed class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class LoadedFavouriteState extends FavouriteState {
  final List<FavoriteModel> items;

  LoadedFavouriteState(this.items);
}

class FavouriteError extends FavouriteState {
  final String error;

  FavouriteError(this.error);
}


