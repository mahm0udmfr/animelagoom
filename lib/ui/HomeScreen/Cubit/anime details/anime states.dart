import '../../../../models/AnimeDetails.dart';

abstract class AnimeState {}

class AnimeInitial extends AnimeState {}

class AnimeLoading extends AnimeState {}

class AnimeLoaded extends AnimeState {
  final AnimeDetails anime;
  AnimeLoaded(this.anime);
}

class AnimeError extends AnimeState {
  final String message;
  AnimeError(this.message);
}
