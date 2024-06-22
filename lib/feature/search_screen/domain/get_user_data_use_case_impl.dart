import 'package:search_git_hub/feature/search_screen/data/search_screen_repository.dart';
import 'package:search_git_hub/feature/search_screen/domain/get_user_data_use_case.dart';

class GetUserDataUseCaseImpl implements GetUserDataUseCase{

  final SearchScreenRepository repository;

  GetUserDataUseCaseImpl({required this.repository });
  @override
  Future<List<String>> getUserData(String token) async {

   return await repository.getUserDataFromRepository(token);
  }


}