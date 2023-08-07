
import 'package:flutter/material.dart';
import 'package:rolebased/student/student_home.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;

  List<Question> questions = [
    Question(
      'What is the capital of France?',
      ['Paris', 'London', 'Berlin', 'Madrid'],
      'Paris',
    ),
    Question(
      'Who painted the Mona Lisa?',
      ['Leonardo da Vinci', 'Pablo Picasso', 'Vincent van Gogh', 'Michelangelo'],
      'Leonardo da Vinci',
    ),
    Question(
      'What is the largest planet in our solar system?',
      ['Jupiter', 'Saturn', 'Neptune', 'Earth'],
      'Jupiter',
    ),
    // Add more questions here
  ];

  void checkAnswer(String selectedAnswer) {
    if (selectedAnswer == questions[currentQuestionIndex].correctAnswer) {
      setState(() {
        score++;
      });
    }
    nextQuestion();
  }

  void nextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        // Quiz is completed
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Aptitude Completed'),
            content: Text('Your score: $score out of ${questions.length}'),
            actions: [
              ElevatedButton(
                child: Text('Home'),
                onPressed: () {
                  setState(() {
                    currentQuestionIndex = 0;
                    score = 0;
                  });
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Aptitude Test'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${currentQuestionIndex + 1}',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              questions[currentQuestionIndex].questionText,
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 16.0),
            ...questions[currentQuestionIndex]
                .answerOptions
                .map((option) => AnswerOption(
              option: option,
              onTap: () => checkAnswer(option),
            ))
                .toList(),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String questionText;
  final List<String> answerOptions;
  final String correctAnswer;

  Question(this.questionText, this.answerOptions, this.correctAnswer);
}

class AnswerOption extends StatelessWidget {
  final String option;
  final VoidCallback onTap;

  AnswerOption({required this.option, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.0),
        padding: EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          color: Colors.yellow[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            option,
            style: TextStyle(fontSize: 18.0, color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
