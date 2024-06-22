import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {



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