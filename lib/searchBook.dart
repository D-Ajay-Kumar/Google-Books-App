import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:xml/xml.dart' as xml;
import 'dart:core';

import 'searchResultsPage.dart';
import 'goodReadsSearchResultsPage.dart';

class SearchBook extends StatefulWidget {
  @override
  State createState() => _SearchBookState();
}

class _SearchBookState extends State<SearchBook> {
  Future searchGoodreadsBook() async {
    final http.Response response = await http.get(
        // API key here
        );
    // final decodedData = xml.parse(response.body);
    // var elements = decodedData.findAllElements('work');

    //print(xmlList);

    return response;
  }

  Future searchGoogleBook() async {
    final http.Response response = await http.get(
        // API key here
        );
    final decodedData = jsonDecode(response.body);

    return decodedData;
  }

  String input;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Search Books",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      hintText: "Book Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onChanged: (value) {
                      input = value.replaceAll(' ', '+');
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Name is required";
                      } else {
                        return null;
                      }
                    },
                    // key: formKey,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Search",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      if (formKey.currentState.validate()) {
                        final response = await searchGoogleBook();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SearchResultsPage(response);
                            },
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
