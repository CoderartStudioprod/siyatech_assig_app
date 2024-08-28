import 'package:flutter/material.dart';
import '../utils/Constants.dart';

class NewsItem extends StatelessWidget {
  final String category;
  final String title;
  final String author;
  Function urllaunch;
  final List commentlistID;
  final int time;
  NewsItem({
    required this.urllaunch,
    required this.commentlistID,
    required this.time,
    required this.category,
    required this.title,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => urllaunch,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueAccent,
                    ),
                  ),
                  Text(
                    Constant.formatDate(time),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.chat_bubble_outline,
                          size: 16, color: Colors.black54),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "Comments",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  Text("by-$author")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
