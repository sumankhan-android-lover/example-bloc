import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:ecommarce/data/local/repository/favorite_repository.dart';
import 'package:ecommarce/features/home/favourite/model/favourite/favorite_model.dart';
import 'package:flutter/cupertino.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final FavoriteRepository repository;

  FavouriteBloc(this.repository) : super(FavouriteInitial()) {
    on<AddRemoveFavouriteEvent>(addRemoveFavoriteProduct); // add data
    on<FetchFavouritesEvent>(loadFavouriteProduct); // get data
    on<RemoveFavouriteEvent>(removeFavouriteProduct); // remove single item
    on<ClearAllFavouritesEvent>(clearAllData); // clear all data
  }

  FutureOr<void> addRemoveFavoriteProduct(AddRemoveFavouriteEvent event, Emitter<FavouriteState> emit) async{
    await repository.addFavourite(event.item);
    final items = repository.getFavourites();
    // debugPrint("favorite data - ${items.length} || ${json.encode(items)}");
    emit(LoadedFavouriteState(items));
  }

  FutureOr<void> loadFavouriteProduct(FetchFavouritesEvent event, Emitter<FavouriteState> emit) {
    final items = repository.getFavourites();
    // debugPrint("favorite data - ${items.length} || ${json.encode(items)}");
    emit(LoadedFavouriteState(items));
  }

  FutureOr<void> removeFavouriteProduct(RemoveFavouriteEvent event, Emitter<FavouriteState> emit) async{
    await repository.deleteFavourite(event.index);
    final items = repository.getFavourites();
    debugPrint("favorite data after delete - ${items.length} || ${json.encode(items)}");
    emit(LoadedFavouriteState(items));
  }

  FutureOr<void> clearAllData(ClearAllFavouritesEvent event, Emitter<FavouriteState> emit) async{
    await repository.clearAllFavourites();
    final items = repository.getFavourites();
    emit(LoadedFavouriteState(items)); // Emit an empty list
  }
}
