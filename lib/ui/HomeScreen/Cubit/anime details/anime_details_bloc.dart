import 'package:animelagoom/ui/HomeScreen/Cubit/anime%20details/anime_details_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/api/api_constatnts.dart';
import '../../../../Core/api/api_manager.dart';
import '../../../../models/anime_and_manga_model.dart';

abstract class MediaDetailsEvent {}
class FetchMediaDetails extends MediaDetailsEvent {
  final String mediaId;
  final MediaType mediaType; // enum to distinguish anime/manga

  FetchMediaDetails(this.mediaId, this.mediaType);
}

enum MediaType { anime, manga }



class MediaDetailsBloc extends Bloc<MediaDetailsEvent, MediaDetailsState> {
  final KitsuApiManager apiManager;

  MediaDetailsBloc(this.apiManager) : super(MediaDetailsInitial()) {
    on<FetchMediaDetails>((event, emit) async {
      emit(MediaDetailsLoading());

      try {
        final isAnime = event.mediaType == MediaType.anime;

        final json = await apiManager.get(
          isAnime 
            ? KitsuApiConstants.animeById(event.mediaId) 
            : KitsuApiConstants.mangaById(event.mediaId)
        );

        final mediaJson = json['data'] as Map<String, dynamic>;
        final mediaItem = MediaItem.fromJson(mediaJson);

        final genres = isAnime 
          ? await apiManager.fetchGenresForAnime(event.mediaId)
          : await apiManager.fetchGenresForManga(event.mediaId);

        final characters = isAnime 
          ? await apiManager.fetchCharactersForAnime(event.mediaId)
          : await apiManager.fetchCharactersForManga(event.mediaId);

        final extraData = isAnime 
          ? await apiManager.fetchEpisodes(event.mediaId)
          : await apiManager.fetchChapters(event.mediaId);

        emit(MediaDetailsLoaded(mediaItem, genres, characters, extraData));
      } catch (e) {
        emit(MediaDetailsError(e.toString()));
      }
    });
  }
}
