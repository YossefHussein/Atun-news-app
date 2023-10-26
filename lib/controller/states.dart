abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsChangeBottomNavIndexState extends NewsStates {}

class NewsGetBusinessSuccessState extends NewsStates {}

class NewsGetBusinessLoadingState extends NewsStates {}

class NewsGetBusinessErrorState extends NewsStates {
  final String? error;
  NewsGetBusinessErrorState({this.error});
}

class NewsGetSportSuccessState extends NewsStates {}

class NewsGetSportLoadingState extends NewsStates {}

class NewsGetSportErrorState extends NewsStates {
  final String? error;
  NewsGetSportErrorState({this.error});
}

class NewsGetScienceSuccessState extends NewsStates {}

class NewsGetScienceLoadingState extends NewsStates {}

class NewsGetScienceErrorState extends NewsStates {
  final String? error;
  NewsGetScienceErrorState({this.error});
}

class ChangeAppMode extends NewsStates {}

class NewsGetSearchSuccess extends NewsStates {}
class NewsGetSearchLoading extends NewsStates {}
class NewsGetSearchError extends NewsStates {
  String error;

  NewsGetSearchError({required this.error});
}


class AppChangeCurrencyDropListState extends NewsStates {}
