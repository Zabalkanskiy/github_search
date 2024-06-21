import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_sign_in_plus/github_sign_in_plus.dart';
import 'package:search_git_hub/secret_key.dart';
import 'package:http/http.dart' as http;

class ApiService {

  static Future<String> gitHubSignIn(BuildContext context) async {
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
      clientId: GITHUB_CLIENT_ID,
      clientSecret: GITHUB_CLIENT_SECRET,

      redirectUrl: 'https://seach-git-hub-1218.firebaseapp.com/__/auth/handler',
      title: 'GitHub Connection',
      centerTitle: false,
    );

    var result = await gitHubSignIn.signIn(context);
    switch (result.status) {
      case GitHubSignInResultStatus.ok:
        debugPrint("SUCCESS RESULT");
        debugPrint(result.token ?? "TOKEN_NOT_FOUND"); //token

        debugPrint("SUCCESS RESULT");
        return result.token ?? "TOKEN_NOT_FOUND";




      case GitHubSignInResultStatus.cancelled:
      case GitHubSignInResultStatus.failed:
        debugPrint(result.errorMessage);
        debugPrint("Error RESULT");
        return "TOKEN_NOT_FOUND";

    }
  }

  static Future<List<String>> fetchGitHubUserData(String accessToken) async {
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

      debugPrint('Имя пользователя: $userName');
      debugPrint('Почта пользователя: $userEmail');
      return [userName, userEmail];
    } else {
      // Если сервер не вернул ответ "ОК", бросаем ошибку
      throw Exception('Failed to load user data');
    }
  }
}