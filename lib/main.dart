import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:search_git_hub/feature/app_root/presentation/ui/app_root.dart';
import 'package:search_git_hub/feature/search_screen/presentation/ui/SearchScreen.dart';
import 'package:search_git_hub/sign_in.dart';

import 'home_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      const MaterialApp(
            localizationsDelegates: [DefaultMaterialLocalizations.delegate],

            home:  AppRoot()),
          );

}
