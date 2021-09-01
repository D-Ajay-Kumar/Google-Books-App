import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:xml/xml.dart';
import 'dart:core';

class GoodReadsSearchResultPage extends StatefulWidget {
  final http.Response response;

  GoodReadsSearchResultPage(this.response);
  @override
  _GoodReadsSearchResultPageState createState() =>
      _GoodReadsSearchResultPageState();
}

class _GoodReadsSearchResultPageState extends State<GoodReadsSearchResultPage> {
  void createTitleList() {
    elements.forEach(
      (element) {
        element.findElements('best_book').forEach(
          (element) {
            titleList.add(element.findElements('title').first.text);
          },
        );
      },
    );
  }

  void createImageList() {
    elements.forEach(
      (element) {
        element.findElements('best_book').forEach(
          (element) {
            if (element.contains('image_url')) {
              imageList.add(element.findElements('image_url').first.text);
            } else {
              imageList.add(null);
            }
          },
        );
      },
    );
  }

  List<String> titleList = [];
  List<String> imageList = [];
  var elements;

  @override
  void initState() {
    super.initState();
    var decodedData = parse(widget.response.body);
    elements = decodedData.findAllElements('work');

    createTitleList();
    createImageList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: elements.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: imageList[index] != null
              ? Image.network(imageList[index])
              : Icon(Icons.add),
          title: Text(
            titleList[index],
          ),
        );
      },
    ));
  }
}
