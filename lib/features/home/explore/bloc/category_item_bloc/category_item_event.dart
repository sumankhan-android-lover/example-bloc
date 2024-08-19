part of 'category_item_bloc.dart';

sealed class CategoryItemEvent {}

class FetchCategoryItemEvent extends CategoryItemEvent {
  String path;

  FetchCategoryItemEvent(this.path);
}