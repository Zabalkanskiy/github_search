import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_git_hub/feature/auth_screen/presentation/bloc/auth_event.dart';
import 'package:search_git_hub/feature/auth_screen/presentation/bloc/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthLoading()) {
    on<CheckSignIn>(_onCheckSignIn);
    on<Logout>(_onLogout);
    on<GetToken>(_onGetToken);
  }

  void _onCheckSignIn(CheckSignIn event, emit) async {
    // проверка перед вводом пароля на экране регистрации
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('logged_in') ?? false) {
      //если пользователь уже был зарегистрован то делаем
      //запрос не дожидаясь экрана с входом
      //и проверяем является ли пользователь валидным
        emit(AuthAutoSignIn());

    } else {
      //открываем экран с входом
      emit(AuthSignIn());
    }
  }
  
  void _onGetToken(GetToken event, emit) async {
    final prefs = await SharedPreferences.getInstance();
    if(event.token != "TOKEN NOT FOUND") {
    prefs.setBool('logged_in', true);
    emit(AuthCompleted(event.token));
    } else {
      emit(AuthSignInError("TOKEN NOT FOUND"));
    }
  }



  void _onLogout(Logout event, emit) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    emit(AuthSignInError(''));
  }
}