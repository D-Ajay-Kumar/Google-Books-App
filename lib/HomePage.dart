import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/services.dart';

import './bookWidget.dart';
import './searchBook.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void searchBook(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return SearchBook();
      },
    );
  }

  void deleteBook(String title) {
    Firestore.instance.collection('books').document(title).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Books",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(
              right: 20,
            ),
            icon: Icon(
              Icons.search,
              size: 30,
            ),
            onPressed: () {
              searchBook(context);
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('books').snapshots(),
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            return ListView.builder(
              itemCount: snapshots.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot documentSnapshot =
                    snapshots.data.documents[index];
                return Slidable(
                  child: BookWidget(
                    documentSnapshot['title'],
                    documentSnapshot['author'],
                    documentSnapshot['imageUrl'],
                  ),
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.35,
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () {
                        deleteBook(snapshots.data.documents[index].documentID);
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            return Align(
              alignment: FractionalOffset.bottomCenter,
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
