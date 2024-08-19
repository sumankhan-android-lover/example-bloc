part of 'favourite_bloc.dart';

sealed class FavouriteEvent {}

class AddRemoveFavouriteEvent extends FavouriteEvent{
  final FavoriteModel item;

  AddRemoveFavouriteEvent(this.item);
}

class FetchFavouritesEvent extends FavouriteEvent{}

class RemoveFavouriteEvent extends FavouriteEvent {
  final int index;

  RemoveFavouriteEvent(this.index);
}

class ClearAllFavouritesEvent extends FavouriteEvent {}
