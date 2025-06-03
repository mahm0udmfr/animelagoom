import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/api/api_manager.dart';
import 'anime states.dart';

class AnimeCubit extends Cubit<AnimeState> {
  final KitsuApiManager apiManager;
  AnimeCubit(this.apiManager) : super(AnimeInitial());

  Future<void> fetchAnime(String id) async {
    try {
      emit(AnimeLoading());
      final anime = await apiManager.fetchAnimeDetails(id);
      if (anime == null) {
        emit(AnimeError('Anime not found'));
      } else {
        emit(AnimeLoaded(anime));
      }
    } catch (e) {
      emit(AnimeError('Failed to load anime details'));
    }
  }
}
