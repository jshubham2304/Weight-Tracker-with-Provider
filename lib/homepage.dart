import 'package:assignment/app_home.dart';
import 'package:assignment/common_utils.dart';
import 'package:assignment/model/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    // print(user.user.email);
    ListTile makeListTile(QueryDocumentSnapshot data, int index) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),

          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: new Text(
                "${index + 1}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              foregroundColor: Colors.black,
            ),
          ),
          title: Text(
            "Weight Tracker  ${data.get('weight')}",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

          subtitle: Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Text("${data.get('timestamp')}",
                    style: TextStyle(color: Colors.white)),
              )
            ],
          ),
          trailing: InkWell(
            onTap: () {
              user.delete(data.id);
            },
            child: Container(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                foregroundColor: Colors.black,
              ),
            ),
          ),
        );

    Card makeCard(QueryDocumentSnapshot data, int index) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(data, index),
          ),
        );

    return StreamBuilder(
        stream: users.doc(user.emailUser).collection("list").snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Image.asset("assets/no_result.gif"));
          }
          if (snapshot.hasData && snapshot.data.docChanges.length == 0) {
            return Center(
                child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Image.asset(
                "assets/no_result.gif",
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ));
          }
          if (snapshot.hasData && snapshot.data.docChanges.length != 0) {
            print("+++++++");
            return Container(
              // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.docChanges.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(snapshot.data.docs[index].data().toString());
                    return InkWell(
                        onTap: () {
                          newTaskModalBottomSheet(
                              context,
                              snapshot.data.docs[index].get('weight'),
                              snapshot.data.docs[index].id);
                        },
                        child: makeCard(snapshot.data.docs[index], index));
                  }),
            );
          }

          return LinearProgressIndicator();
          // return makeBody(String x, String y);
        });
  }
}
