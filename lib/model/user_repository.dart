import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserRepository with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  String uuid;
  String emailUser;
  bool showFab = true;
  Status _status = Status.Uninitialized;

  // UserRepository() :
  UserRepository() {
    _auth = FirebaseAuth.instance;
    SharedPreferences.getInstance().then((value) {
      if (value.containsKey("userid")) {
        _status = Status.Authenticated;
        emailUser = value.getString("userid");
        notifyListeners();
      } else {
        emailUser = null;
      }
    });
  }
  Status get status => _status;
  User get user => _user;

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        _user = value.user;
        emailUser = email;
        _status = Status.Authenticated;
        notifyListeners();
        SharedPreferences.getInstance().then((pref) {
          pref.setString("userid", _user.email);
        });
      });

      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();

    _status = Status.Unauthenticated;

    notifyListeners();
    SharedPreferences.getInstance().then((value) {
      value.clear();
    });
    return Future.delayed(Duration.zero);
  }

  addWeight(String text) {
    CollectionReference db = FirebaseFirestore.instance.collection('users');
    print(text);
    print(emailUser);
    db.doc(emailUser).collection('list').add({
      "weight": text,
      "timestamp":
          "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}(${DateTime.now().hour}:${DateTime.now().minute})",
    }).then((value) {
      print(value);
      if (value != null) {
        return true;
      } else {
        return false;
      }
    });
  }

  updateWeight(String text, String id) {
    CollectionReference db = FirebaseFirestore.instance.collection('users');
    print(text);
    print(emailUser);
    db.doc(emailUser).collection('list').doc(id).update({
      "weight": text,
      "timestamp":
          "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}(${DateTime.now().hour}:${DateTime.now().minute})",
    }).then((value) {
      return value;
    });
  }

  delete(String id) {
    CollectionReference db = FirebaseFirestore.instance.collection('users');
    print(emailUser);
    db.doc(emailUser).collection("list").doc(id).delete();
    notifyListeners();
  }

  floatChangeFalse() {
    showFab = false;
    notifyListeners();
  }

  floatChangeTrue() {
    showFab = true;
    notifyListeners();
  }
}
