import 'package:animelagoom/Core/api/api_manager.dart';
import 'package:animelagoom/Services/anime_service.dart';
import 'package:animelagoom/ui/HomeScreen/Cubit/home_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenViewModel extends Cubit<HomeScreenStates> {
  HomeScreenViewModel() : super(LoadingState());

  final animeService = AnimeService(KitsuApiManager());


  Future<void> searchAnime(String query) async {
    try {
      emit(LoadingState());
      final results = await animeService.searchAnime(query);
      emit(SearchLoadedState(searchResults: results));
    } catch (e) {
      emit(SearchErrorState(errorMessage: e.toString()));
    }
  }


}







