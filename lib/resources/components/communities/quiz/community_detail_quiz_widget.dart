import 'package:flutter/material.dart';
import 'package:while_app/resources/components/communities/quiz/add_quiz.dart';
import 'package:while_app/resources/components/communities/quiz/quiz.dart';
import 'package:while_app/resources/components/message/models/community_user.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key, required this.user});

  final CommunityUser user;

  _createQuiz(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AddQuestionScreen(user: user,)),
  );
}



void _easyQuiz(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Quiz(user: user, category: 'Easy'),),
  );
}

void _mediumQuiz(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Quiz(user: user, category: 'Medium'),),
  );
}

void _hardQuiz(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Quiz(user: user, category: 'Hard'),),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          GestureDetector(
            onTap: () => _easyQuiz(context),
            child: QuizTile(level: 'Easy', gradientColors: [Colors.blue, Colors.green])),
          GestureDetector(
            onTap: () => _mediumQuiz(context),
            child: QuizTile(level: 'Medium', gradientColors: [Colors.orange, Colors.yellow])),
          GestureDetector(
            onTap: () => _hardQuiz(context),
            child: QuizTile(level: 'Hard', gradientColors: [Colors.red, Colors.purple])),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createQuiz(context),
        child: Icon(Icons.add),
    ),
      );
  }
}

class QuizTile extends StatelessWidget {
  final String level;
  final List<Color> gradientColors;

  QuizTile({required this.level, required this.gradientColors});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          level,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
