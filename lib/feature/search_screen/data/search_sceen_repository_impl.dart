import 'package:search_git_hub/core/api/api_service.dart';
import 'package:search_git_hub/feature/search_screen/data/search_screen_repository.dart';

class SearchScreenRepositoryImpl implements SearchScreenRepository{
  @override
  Future<List<String>> getUserDataFromRepository(String token) async{
   List<String> response = await ApiService.fetchGitHubUserData(token);
   return response;
  }

}