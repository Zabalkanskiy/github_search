abstract class SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  final String error;

  SearchError(this.error);
}

class SearchLoaded extends SearchState {

  final String userName;
  final String email;
  SearchLoaded(this.userName, this.email);
}