import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Screen'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'What is the capital of France?',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Options:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                ListTile(
                  title: Text('A. Paris'),
                  onTap: () {
                    // Handle option A selection
                  },
                ),
                ListTile(
                  title: Text('B. London'),
                  onTap: () {
                    // Handle option B selection
                  },
                ),
                ListTile(
                  title: Text('C. Rome'),
                  onTap: () {
                    // Handle option C selection
                  },
                ),
                ListTile(
                  title: Text('D. Berlin'),
                  onTap: () {
                    
                    // Handle option D selection
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
