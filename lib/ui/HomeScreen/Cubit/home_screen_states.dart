abstract class HomeScreenStates {}

class LoadingState extends HomeScreenStates {}
class LoadedState extends HomeScreenStates {
  final List<dynamic> animeList;
  LoadedState({required this.animeList});
}
class LoadingErrorState extends HomeScreenStates {
  String errorMessage;
  LoadingErrorState({required this.errorMessage});
}


class SearchState extends HomeScreenStates {
  final List<dynamic> searchResults;
  SearchState({required this.searchResults});
}

class SearchLoadingState extends HomeScreenStates {}

class SearchErrorState extends HomeScreenStates {
  String errorMessage;
  SearchErrorState({required this.errorMessage});
}

class SearchInitialState extends HomeScreenStates {}

class SearchLoadedState extends HomeScreenStates {
  final List<dynamic> searchResults;
  SearchLoadedState({required this.searchResults});
}

class SearchEmptyState extends HomeScreenStates {
  final String message;
  SearchEmptyState({required this.message});
}
