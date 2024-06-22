import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:search_git_hub/feature/app_root/presentation/ui/app_text_dialog.dart';
import 'package:search_git_hub/feature/detail_screen/presentation/ui/detail_screen.dart';
import 'package:search_git_hub/feature/search_screen/data/git_user.dart';
import 'package:search_git_hub/feature/search_screen/presentation/bloc/search_bloc.dart';
import 'package:search_git_hub/feature/search_screen/presentation/bloc/search_event.dart';
import 'package:search_git_hub/feature/search_screen/presentation/bloc/search_state.dart';

class SearchScreen extends StatefulWidget {
  final String token;
  const SearchScreen({super.key, required this.token});

  @override
  State<SearchScreen> createState() {
    return _SearchScreenState();
  }
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<GitUser> _results = List.empty(growable: true);
  Timer? _debounce;
  String userName = 'Loading';
  String userEmail = 'Loading';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(listener: (context, state) {
      if (state is SearchError) {
        if (state.error.isNotEmpty) {
          showDialog(
            context: context,
            //нужно показать ошибку
            builder: (context) => AppTextDialog(state.error),
          );
        }
      } else if (state is SearchLoaded){
        // setState(() {
          userName = state.userName;
          userEmail = state.email;
        // });

      }

    }, builder: (context, state) {


      return Scaffold(
        appBar: AppBar(
          title: const Text('Search GitHub'),
        ),
        body: Container(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child:
                    Text(
                      'Your name: $userName', // Отображение имени пользователя
                      style: const TextStyle(fontSize: 16.0),
                    ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child:
                Text(
                  'Email: $userEmail', // Отображение почты пользователя
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    suffixIcon: //IconButton(
                    Icon(Icons.search),
                    //   onPressed: () => _search(_controller.text),
                  ),
                ),
              ),
              // Image.asset('assets/user.png'),

              //),
              Expanded(
                child: ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
                      child: ListTile(
                        // leading: Image.asset('assets/user.png'),
                        leading: CircleAvatar(
                          backgroundImage: _results[index].avatarUrl.isNotEmpty
                              ? FadeInImage
                              .assetNetwork(
                            fit: BoxFit.cover,
                            placeholder: 'assets/user.png',
                            image: _results[index].avatarUrl,
                          )
                              .image
                              : const AssetImage('assets/user.png'),
                        ),
                        title: const Text("Login"),
                        subtitle: Text(_results[index].login),
                        trailing: const Icon(Icons.arrow_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DetailScreen(user: _results[index])),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
    );
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged); // Добавьте слушатель к контроллеру
    BlocProvider.of<SearchBloc>(context).add(LoadUserData(widget.token));
  }

  @override
  void dispose() {
    _controller.removeListener(_onSearchChanged); // Удалите слушатель
    _controller.dispose();
    _debounce?.cancel(); // Отмените _debounce таймер
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel(); // Отмените текущий таймер
    _debounce = Timer(const Duration(milliseconds: 200), () {
      _search(_controller.text, widget.token); // Вызовите _search после задержки
    });
  }

  Future<void> _search(String query, String token) async {
    final response = await http.get(
        Uri.parse('https://api.github.com/search/users?q=$query'),
        headers: {'Authorization': 'token $token'}
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _results = List<GitUser>.from(data['items'].map((item) => GitUser.fromJson(item)));
      });
    } else {
      // Обработка ошибки
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
