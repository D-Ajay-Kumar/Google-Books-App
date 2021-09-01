import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';

class BookWidget extends StatelessWidget {
  final String title;
  final String author;
  final String imageUrl;

  BookWidget(this.title, this.author, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            imageUrl != null
                ? Image(
                    image: NetworkImage(
                      imageUrl,
                    ),
                    fit: BoxFit.fill,
                    width: 110,
                    height: 150,
                  )
                : Icon(
                    Icons.image,
                    size: 125,
                  ),
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 8,
              ),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.53,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.53,
                    child: Text(
                      author,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                      ),
                    ),
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
