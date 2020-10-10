import 'package:assignment/animation.dart';
import 'package:assignment/model/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _email;
  TextEditingController _password;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: "");
    _password = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);

    return Scaffold(
        key: _key,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/background.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        child: FadeAnimation(
                            1.6,
                            Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        FadeAnimation(
                          1.8,
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[100]))),
                                  child: TextFormField(
                                    controller: _email,
                                    validator: (value) => (value.isEmpty)
                                        ? "Please enter Email"
                                        : null,
                                    style: style,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: _password,
                                    validator: (value) => (value.isEmpty)
                                        ? "Please enter  Password"
                                        : null,
                                    style: style,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        user.status == Status.Authenticating
                            ? Center(child: CircularProgressIndicator())
                            : FadeAnimation(
                                2,
                                InkWell(
                                  onTap: () async {
                                    if (_formKey.currentState.validate()) {
                                      if (!await user.signIn(
                                          _email.text, _password.text))
                                        _key.currentState.showSnackBar(SnackBar(
                                          content: Text("Something is wrong"),
                                        ));
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(colors: [
                                          Color.fromRGBO(143, 148, 251, 1),
                                          Color.fromRGBO(143, 148, 251, .6),
                                        ])),
                                    child: Center(
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )),
                        SizedBox(
                          height: 70,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  // @override
  // Widget build(BuildContext context) {
  //   final user = Provider.of<UserRepository>(context);
  //   return Scaffold(
  //     key: _key,
  //     body: Form(
  //       key: _formKey,
  //       child: Center(
  //         child: ListView(
  //           shrinkWrap: true,
  //           children: <Widget>[
  //             Padding(
  //               padding: const EdgeInsets.all(16.0),
  //               child: TextFormField(
  //                 controller: _email,
  //                 validator: (value) =>
  //                     (value.isEmpty) ? "Please Enter Email" : null,
  //                 style: style,
  //                 decoration: InputDecoration(
  //                     prefixIcon: Icon(Icons.email),
  //                     labelText: "Email",
  //                     border: OutlineInputBorder()),
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(16.0),
  //               child: TextFormField(
  //                 controller: _password,
  //                 validator: (value) =>
  //                     (value.isEmpty) ? "Please Enter Password" : null,
  //                 style: style,
  //                 decoration: InputDecoration(
  //                     prefixIcon: Icon(Icons.lock),
  //                     labelText: "Password",
  //                     border: OutlineInputBorder()),
  //               ),
  //             ),
  //             user.status == Status.Authenticating
  //                 ? Center(child: CircularProgressIndicator())
  //                 : Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //                     child: Material(
  //                       elevation: 5.0,
  //                       borderRadius: BorderRadius.circular(30.0),
  //                       color: Colors.red,
  //                       child: MaterialButton(
  //                         onPressed: () async {
  //                           if (_formKey.currentState.validate()) {
  //                             if (!await user.signIn(
  //                                 _email.text, _password.text))
  //                               _key.currentState.showSnackBar(SnackBar(
  //                                 content: Text("Something is wrong"),
  //                               ));
  //                           }
  //                         },
  //                         child: Text(
  //                           "Sign In",
  //                           style: style.copyWith(
  //                               color: Colors.white,
  //                               fontWeight: FontWeight.bold),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //             SizedBox(height: 20),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}
