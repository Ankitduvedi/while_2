//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:quiz_app/data/questions.dart';
// import 'package:quiz_app/questions_summary.dart';
//import 'package:quiz_app/quiz.dart';
//import 'package:quiz_app/start_screen.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(
      {super.key, required this.chosenAnswers, required this.onPressed});

  final List<String> chosenAnswers;
  final void Function() onPressed;

  // List<Map<String, Object>> getSummaryData() {
  //   final List<Map<String, Object>> summary = [];

  //   for (var i = 0; i < chosenAnswers.length; i++) {
  //     summary.add(
  //       {
  //         'question_index': i,
  //         'question': questions[i].text,
  //         'correct_answer': questions[i].answers[0],
  //         'user_answer': chosenAnswers[i]
  //       },
  //     );
  //   }

  //   return summary;
  // }

  @override
  Widget build(context) {
    // final summaryData = getSummaryData();
    // //final numTotalQuestions = questions.length;
    // final numCorrectAnswers = summaryData.where((data) {
    //   return data['user_answer'] == data['correct_answer'];
    // }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(


        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'You answered out of questions correctly!',
                style: const TextStyle(fontSize: 25),
                textAlign: TextAlign.center),
            const SizedBox(height: 40),
            // QuestionsSummary(summaryData),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton.icon(onPressed: onPressed, 
            icon: const Icon(Icons.cached_outlined),
            label: const Text(style: TextStyle(fontSize: 20),'Restart Quiz'))
          ],
        ),
      ),
    );
  }
}
