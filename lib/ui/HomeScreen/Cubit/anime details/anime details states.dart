import '../../../../models/anime_and_manga_model.dart';

abstract class AnimeDetailsEvent {}

class FetchAnimeDetails extends AnimeDetailsEvent {
  final String animeId;
  FetchAnimeDetails(this.animeId);
}
class LoadEpisodes extends AnimeDetailsEvent {
  final String animeId;
  LoadEpisodes(this.animeId);
}

// anime_details_state.dart
abstract class AnimeDetailsState {}

class AnimeDetailsInitial extends AnimeDetailsState {}

class AnimeDetailsLoading extends AnimeDetailsState {}

class AnimeDetailsLoaded extends AnimeDetailsState {
  final MediaItem anime;
  final List<Genre> genres;
  final List<Character>? characters;
  final List<Episode> episodes;
  AnimeDetailsLoaded(this.anime, this.genres, this.characters, this.episodes);
}

class AnimeDetailsError extends AnimeDetailsState {
  final String message;
  AnimeDetailsError(this.message);
}

