import 'package:assignment/common_utils.dart';
import 'package:assignment/homepage.dart';
import 'package:assignment/model/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  HomeScreen({this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weight Tracker"),
        centerTitle: true,
        backgroundColor: Color(0xff646ada),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Provider.of<UserRepository>(context).signOut(),
            icon: Icon(Icons.logout),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        onPressed: () {
          newTaskModalBottomSheet(context);
          // Provider.of<UserRepository>(context).floatChangeFalse();
        },
        label: Container(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Add Weight → ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: ListPage(),
    );
  }
}
