import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/api/api_constatnts.dart';
import '../../../../Core/api/api_manager.dart';
import '../../../../models/anime_and_manga_model.dart';
import 'anime details states.dart';

class AnimeDetailsBloc extends Bloc<AnimeDetailsEvent, AnimeDetailsState> {
  final KitsuApiManager apiManager;
  AnimeDetailsBloc(this.apiManager) : super(AnimeDetailsInitial()) {
    on<FetchAnimeDetails>((event, emit) async {
      emit(AnimeDetailsLoading());
      try {
        final json = await apiManager.get(KitsuApiConstants.animeById(event.animeId));
        // The Kitsu API wraps data under 'data', your model expects the raw attributes
        final mediaJson = json['data'] as Map<String, dynamic>;
        final anime = MediaItem.fromJson(mediaJson);
        final genres = await apiManager.fetchGenresForAnime(event.animeId);
        final characters = await apiManager.fetchCharactersForAnime(event.animeId);
        final episodes = await apiManager.fetchEpisodes(event.animeId);

        emit(AnimeDetailsLoaded(anime,genres,characters,episodes));
      } catch (e) {
        emit(AnimeDetailsError(e.toString()));
      }
    });
  }


}
