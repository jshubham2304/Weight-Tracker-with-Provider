import 'package:assignment/app_home.dart';
import 'package:assignment/homepage.dart';
import 'package:assignment/login_page.dart';
import 'package:assignment/model/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => UserRepository(),
      child: Consumer(
        builder: (context, UserRepository user, _) {
          print(user.status);
          switch (user.status) {
            case Status.Uninitialized:
              return LoginPage();
            case Status.Unauthenticated:
              return LoginPage();
            case Status.Authenticated:
              return HomeScreen(user: user.user);
            case Status.Authenticating:
              return LoginPage();
              break;
          }
        },
      ),
    );
  }
}
