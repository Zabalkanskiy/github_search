import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:search_git_hub/feature/detail_screen/presentation/data/detail_repository.dart';
import 'package:search_git_hub/feature/detail_screen/presentation/ui/detail_repository_item.dart';
import 'package:search_git_hub/feature/search_screen/data/git_user.dart';
import 'package:http/http.dart' as http;

class DetailScreen extends StatefulWidget {
  final GitUser user;

  const DetailScreen({super.key, required this.user});

  @override
  _DetailScreenState createState() => _DetailScreenState();

  }

class _DetailScreenState extends State<DetailScreen> {
  List<DetailRepositoryModel> repositories = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchRepositories();
  }

  Future<void> fetchRepositories() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse('https://api.github.com/users/${widget.user.login}/repos'));

    if (response.statusCode == 200) {
      final List<dynamic> repoJson = json.decode(response.body) as List;
      setState(() {
        repositories = repoJson.map((jsonItem) => DetailRepositoryModel.fromJson(jsonItem)).toList();
        isLoading = false;
      });
    } else {
      // Обработка ошибок
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User: ${widget.user.login}"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: repositories.length,
        itemBuilder: (context, index) {
          return DetailRepositoryItem(repository: repositories[index]);
        },
      ),
    );
  }
}

//
//   const DetailScreen({super.key, required this.user});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("User: ${user.login}"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             Text('ID пользователя: ${user.id}'),
//             // Другие детали пользователя
//           ],
//         ),
//       ),
//     );
//   }
// }