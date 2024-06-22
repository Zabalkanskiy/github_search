abstract class SearchEvent {}

class LoadUserData extends SearchEvent {
  final String token;
  LoadUserData(this.token);
}