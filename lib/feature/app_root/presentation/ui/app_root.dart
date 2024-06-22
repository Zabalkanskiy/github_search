import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_git_hub/feature/auth_screen/presentation/bloc/auth_bloc.dart';
import 'package:search_git_hub/feature/auth_screen/presentation/bloc/auth_event.dart';
import 'package:search_git_hub/feature/auth_screen/presentation/ui/auth_screen.dart';
import 'package:search_git_hub/feature/search_screen/data/search_sceen_repository_impl.dart';
import 'package:search_git_hub/feature/search_screen/domain/get_user_data_use_case_impl.dart';
import 'package:search_git_hub/feature/search_screen/presentation/bloc/search_bloc.dart';

class AppRoot extends StatelessWidget{
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (context) => AuthBloc()
      ..add(CheckSignIn())),
          BlocProvider<SearchBloc>(create: (context) => SearchBloc(GetUserDataUseCaseImpl(repository: SearchScreenRepositoryImpl())))
        ],
        child: ResponsiveSizer(builder: (context, orientation, screenType){
          return const MaterialApp(
            localizationsDelegates: [DefaultMaterialLocalizations.delegate],
            debugShowCheckedModeBanner: false,

            home: AuthScreen(),
          );
        })
    );
  }



}
