import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/user_repository.dart';

newTaskModalBottomSheet(BuildContext context, [String text, String id]) {
  String _newWeight = text;
  print(id);
  print(_newWeight);
  showModalBottomSheet(
      context: context,
      builder: (BuildContext contextt) {
        return new StatefulBuilder(
            builder: (BuildContext ctxt, StateSetter stateSetter) {
          return Container(
            height: 400,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0),
              ),
            ),
            child: new Column(
              children: <Widget>[
                new Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Container(
                        height: 250,
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(10.0),
                            topRight: const Radius.circular(10.0),
                          ),
                        ),
                        child: Wrap(
                          children: <Widget>[
                            new TextField(
                              onChanged: (newTask) {
                                _newWeight = newTask;
                              },
                              autofocus: true,
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: text ?? 'New Weight Number',
                              ),
                              autocorrect: false,
                              keyboardType: TextInputType.text,
                            ),
                            FlatButton(
                              onPressed: () {
                                if (id != null) {
                                  Provider.of<UserRepository>(context)
                                      .updateWeight(_newWeight, id);
                                  Navigator.pop(context);
                                } else {
                                  Provider.of<UserRepository>(context)
                                      .floatChangeTrue();
                                  Provider.of<UserRepository>(context)
                                      .addWeight(_newWeight);
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text(
                                'Save',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.blue,
                                ),
                              ),
                              color: Colors.white,
                              splashColor: Colors.blue,
                              textColor: Theme.of(context).accentColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
      });
}
