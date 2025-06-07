import 'package:animelagoom/models/anime_and_manga_model.dart';

abstract class MediaDetailsState {}
class MediaDetailsInitial extends MediaDetailsState {}
class MediaDetailsLoading extends MediaDetailsState {}
class MediaDetailsLoaded extends MediaDetailsState {
  final MediaItem mediaItem;
  final List<dynamic> genres;
  final List<dynamic> characters;
  final List<dynamic> extraData; // episodes for anime, chapters for manga

  MediaDetailsLoaded(this.mediaItem, this.genres, this.characters, this.extraData);
}
class MediaDetailsError extends MediaDetailsState {
  final String message;
  MediaDetailsError(this.message);
}