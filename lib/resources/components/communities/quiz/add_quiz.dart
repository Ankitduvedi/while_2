import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:while_app/resources/components/communities/quiz/quiz_model.dart';
import 'package:while_app/resources/components/message/models/community_user.dart';

final uuid = Uuid();

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class AddQuestionScreen extends StatefulWidget {
  const AddQuestionScreen({Key? key, required this.user}) : super(key: key);
  final CommunityUser user;

  @override
  _AddQuestionScreenState createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  TextEditingController questionController = TextEditingController();
  TextEditingController option1Controller = TextEditingController();
  TextEditingController option2Controller = TextEditingController();
  TextEditingController option3Controller = TextEditingController();
  TextEditingController option4Controller = TextEditingController();

  String correctAnswer = 'A';
  String selectedOption = 'A';
  List<Map<String, dynamic>> questions = [];
  List<String> options = ['A', 'B', 'C', 'D'];
  List<String> categories = ['Easy', 'Medium', 'Hard'];
  String selectedCategory = 'Easy';

void _saveQuestion() async {
  final newQuestion = Questions(
    id: uuid.v4(),
    question: questionController.text,
    options: {
      'A': option1Controller.text,
      'B': option2Controller.text,
      'C': option3Controller.text,
      'D': option4Controller.text,
    },
    correctAnswer: selectedOption,
  );

  FirebaseFirestore.instance
      .collection('communities')
      .doc(widget.user.id)
      .collection('quizzes')
      .doc(widget.user.id)
      .collection('$selectedCategory')
      .doc(newQuestion.id)
      .set({
    'question': newQuestion.question,
    'options': newQuestion.options,
    'correctAnswer': newQuestion.correctAnswer,
    'id': newQuestion.id,
  }).then((_) {
    questionController.clear();
    option1Controller.clear();
    option2Controller.clear();
    option3Controller.clear();
    option4Controller.clear();
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Question'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: questionController,
                maxLines: null,
                decoration: InputDecoration(labelText: 'Question'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: option1Controller,
                decoration: InputDecoration(labelText: 'Option 1'),
              ),
              TextField(
                controller: option2Controller,
                decoration: InputDecoration(labelText: 'Option 2'),
              ),
              TextField(
                controller: option3Controller,
                decoration: InputDecoration(labelText: 'Option 3'),
              ),
              TextField(
                controller: option4Controller,
                decoration: InputDecoration(labelText: 'Option 4'),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text('Correct Answer:'),
                  SizedBox(width: 10),
                  DropdownButton<String>(
                    value: selectedOption,
                    onChanged: (String? value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                    items: options.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text('Category:'),
                  SizedBox(width: 10),
                  DropdownButton<String>(
                    value: selectedCategory,
                    onChanged: (String? value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                    items: categories.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _saveQuestion();
                  Navigator.pop(context);

                  
                },
                child: Text('Save Question'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
