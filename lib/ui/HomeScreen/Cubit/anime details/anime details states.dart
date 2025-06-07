import '../../../../models/anime_and_manga_model.dart';

abstract class AnimeDetailsEvent {}

class FetchAnimeDetails extends AnimeDetailsEvent {
  final String animeId;
  FetchAnimeDetails(this.animeId);
}

// anime_details_state.dart
abstract class AnimeDetailsState {}

class AnimeDetailsInitial extends AnimeDetailsState {}

class AnimeDetailsLoading extends AnimeDetailsState {}

class AnimeDetailsLoaded extends AnimeDetailsState {
  final MediaItem anime;
  final List<Genre> genres;
  AnimeDetailsLoaded(this.anime, this.genres);
}

class AnimeDetailsError extends AnimeDetailsState {
  final String message;
  AnimeDetailsError(this.message);
}

