
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_git_hub/feature/search_screen/domain/get_user_data_use_case.dart';
import 'package:search_git_hub/feature/search_screen/presentation/bloc/search_event.dart';
import 'package:search_git_hub/feature/search_screen/presentation/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetUserDataUseCase getUserDataUseCase;
  SearchBloc(this.getUserDataUseCase) : super(SearchLoading()) {
    on<LoadUserData>(_loadUserData);

  }

  void _loadUserData(LoadUserData event, emit) async {
    try {
    var responce = await  getUserDataUseCase.getUserData(event.token);
    emit(SearchLoaded(responce[0], responce[1]));

    } catch (e) {
      emit(SearchError("Error load User Data"));
    }

  }

}