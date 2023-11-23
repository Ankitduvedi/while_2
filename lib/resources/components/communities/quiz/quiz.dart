import 'package:flutter/material.dart';
import 'package:while_app/resources/components/communities/quiz/Screens/easy_questions_screen.dart';
import 'package:while_app/resources/components/communities/quiz/Screens/hard_questions_screen.dart';
import 'package:while_app/resources/components/communities/quiz/Screens/medium_questions_screen.dart';
import 'package:while_app/resources/components/communities/quiz/Screens/results_screen.dart';
import 'package:while_app/resources/components/communities/quiz/Screens/start_screen.dart';
import 'package:while_app/resources/components/message/models/community_user.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key, required this.user, required this.category});
  final CommunityUser user;
  final String category;

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  Widget? activeScreeen;

  @override
  void initState() {
    activeScreeen = StartScreen(switchScreen);
    super.initState();
  }

  void switchScreen() {
    setState(
      () {
        if (widget.category == 'Easy') {
          activeScreeen = EasyQuestionsScreen(
            onSelectAnswer: chooseAnswer,
            user: widget.user,
          );
        }
        if (widget.category == 'Medium') {
          activeScreeen = MediumQuestionsScreen(
            onSelectAnswer: chooseAnswer,
            user: widget.user,
          );
        }
        if (widget.category == 'Hard') {
          activeScreeen = HardQuestionsScreen(
            onSelectAnswer: chooseAnswer,
            user: widget.user,
          );
        }
      },
    );
  }

  void restartQuiz() {
    setState(() {
      activeScreeen = StartScreen(switchScreen);
      selectedAnswers = [];
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == 5) {
      setState(() {
        activeScreeen = ResultsScreen(
          chosenAnswers: selectedAnswers,
          onPressed: restartQuiz,
        );
      });
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.lightBlue, Colors.tealAccent],
          ),
        ),
        child: Center(child: activeScreeen),
      ),
    );
  }
}
