import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_git_hub/feature/auth_screen/presentation/bloc/auth_bloc.dart';
import 'package:search_git_hub/feature/auth_screen/presentation/bloc/auth_event.dart';
import 'package:search_git_hub/feature/auth_screen/presentation/ui/auth_screen.dart';

class AppRoot extends StatelessWidget{
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(create: (context) => AuthBloc()
      ..add(CheckSignIn()),
        child: ResponsiveSizer(builder: (context, orientation, screenType){
          return const MaterialApp(
            localizationsDelegates: [DefaultMaterialLocalizations.delegate],

            home: AuthScreen(),
          );
        })
    );
  }



}
