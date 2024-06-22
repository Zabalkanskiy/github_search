import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github_sign_in_plus/github_sign_in_plus.dart';
import 'package:search_git_hub/feature/app_root/presentation/ui/app_text_dialog.dart';
import 'package:search_git_hub/feature/auth_screen/presentation/bloc/auth_bloc.dart';
import 'package:search_git_hub/feature/auth_screen/presentation/bloc/auth_event.dart';
import 'package:search_git_hub/feature/auth_screen/presentation/bloc/auth_state.dart';
import 'package:search_git_hub/feature/auth_screen/presentation/ui/loading_widget.dart';
import 'package:search_git_hub/feature/search_screen/presentation/ui/SearchScreen.dart';
import 'package:http/http.dart' as http;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  final GitHubSignIn gitHubSignIn = GitHubSignIn(
    clientId: dotenv.env['GITHUB_CLIENT_ID']!,
    clientSecret: dotenv.env['GITHUB_CLIENT_SECRET']!,
    redirectUrl: 'https://seach-git-hub-1218.firebaseapp.com/__/auth/handler',
    title: 'GitHub Connection',
    centerTitle: false,
  );

  @override
  void initState() {
    super.initState();
  }


  void _gitHubSignIn(BuildContext context) async {
    var result = await gitHubSignIn.signIn(context);
    switch (result.status) {
      case GitHubSignInResultStatus.ok:
        debugPrint("SUCCESS RESULT");
        print(result.token ?? "TOKEN NOT FOUND");

        debugPrint("SUCCESS RESULT");
        if (!context.mounted) return;
        BlocProvider.of<AuthBloc>(context).add(GetToken(result.token ?? "TOKEN NOT FOUND"));

      //  fetchGitHubUserData(result.token!);

        break;

      case GitHubSignInResultStatus.cancelled:
      case GitHubSignInResultStatus.failed:
        print(result.errorMessage);
        debugPrint("Error RESULT");
        if (!context.mounted) return;
        BlocProvider.of<AuthBloc>(context).add(GetToken(result.token ?? "TOKEN NOT FOUND"));
        break;
    }
  }

  // Функция для получения данных пользователя GitHub
  Future<void> fetchGitHubUserData(String accessToken) async {
    // Запрос к GitHub API для получения данных пользователя
    final response = await http.get(
      Uri.parse('https://api.github.com/user'),
      // Установка заголовков запроса
      headers: {
        'Authorization': 'token $accessToken',
      },
    );

    if (response.statusCode == 200) {
      // Если сервер вернул ответ "ОК", парсим JSON
      final userData = json.decode(response.body);
      // Получаем имя и почту пользователя
      final String userName = userData['name'];
      final String userEmail = userData['email'];
      // Отображаем имя и почту пользователя
      print('Имя пользователя: $userName');
      print('Почта пользователя: $userEmail');
    } else {
      // Если сервер не вернул ответ "ОК", бросаем ошибку
      throw Exception('Failed to load user data');
    }
  }

// В вашем коде Flutter, вызовите эту функцию с вашим токеном
// fetchGitHubUserData('your_github_token_here');

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is AuthSignInError) {
        if (state.error.isNotEmpty) {
          showDialog(
            context: context,
            //нужно показать ошибку
            builder: (context) => AppTextDialog(state.error),
          );
        }
      }
    }, builder: (context, state) {


      //Из-за неработающих запросов сразу пускаю TrackingScreen
      if (state is AuthCompleted) {
        return  SearchScreen(token: state.token);
      }

      if(state is AuthAutoSignIn){

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _gitHubSignIn(context);
          }
        });

      }

      if (state is AuthSignIn) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Search Github"),
          ),
          body: Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(

                foregroundColor: Colors.black, // Цвет текста кнопки
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),

              onPressed: () {
                _gitHubSignIn(context);
              },
              child: const Text("GitHub Sign In"),
            ),
          ),
        );
      }
      return const Loading(color: Colors.white,);
    });
  }
}
