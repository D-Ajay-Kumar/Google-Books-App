import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import './bookWidget.dart';
import './HomePage.dart';

// page count = items[0].volumeInfo.pageCount

class SearchResultsPage extends StatefulWidget {
  final resultData;

  SearchResultsPage(this.resultData);
  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  void createBook(String title, String author, String imageUrl) {
    Firestore firestore = Firestore.instance;

    firestore.collection('books').add(
      {
        'title': title,
        'author': author,
        'imageUrl': imageUrl,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Books Search Result",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: widget.resultData['items'].length,
        itemBuilder: (context, index) {
          return Slidable(
            child: BookWidget(
              widget.resultData['items'][index]['volumeInfo']
                      .containsKey('title')
                  ? '${widget.resultData['items'][index]['volumeInfo']['title']}'
                  : 'Unknown Title',
              widget.resultData['items'][index]['volumeInfo']
                      .containsKey('authors')
                  ? 'By ${widget.resultData['items'][index]['volumeInfo']['authors'][0]}'
                  : 'By Unknown',
              widget.resultData['items'][index]['volumeInfo']
                      .containsKey('imageLinks')
                  ? '${widget.resultData['items'][index]['volumeInfo']['imageLinks']['thumbnail']}'
                  : null,
            ),
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.35,
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Add',
                color: Colors.green,
                icon: Icons.book,
                onTap: () {
                  createBook(
                    widget.resultData['items'][index]['volumeInfo']
                            .containsKey('title')
                        ? '${widget.resultData['items'][index]['volumeInfo']['title']}'
                        : 'Unknown Title',
                    widget.resultData['items'][index]['volumeInfo']
                            .containsKey('authors')
                        ? 'By ${widget.resultData['items'][index]['volumeInfo']['authors'][0]}'
                        : 'By Unknown',
                    widget.resultData['items'][index]['volumeInfo']
                            .containsKey('imageLinks')
                        ? '${widget.resultData['items'][index]['volumeInfo']['imageLinks']['thumbnail']}'
                        : null,
                  );
                  Navigator.popUntil(
                    context,
                    ModalRoute.withName('/'),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
