import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz_app/data/questions.dart';
import 'package:quizz_app/questions_sumarry.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This widget displays the results of the quiz and shows the user's score, using questions_summary.dart

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.onRestart,
  });

  final List<String> chosenAnswers;
  final void Function() onRestart;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];
    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].text,
          'correct_answer': questions[i].answers[0],
          'user_answer': chosenAnswers[i],
        },
      );
    }
    return summary;
  }

  // Best score function
  Future<void> updateBestScore(int score) async {
    // udpate the best score
    final prefs = await SharedPreferences.getInstance();
    final bestScore = prefs.getInt('bestScore') ?? 0;
    if (score > bestScore) {
      await prefs.setInt('bestScore', score);
    }

    // update infos for average score
    final totalScore = prefs.getInt('totalScore') ?? 0;
    final numOfQuizzes = prefs.getInt('numOfQuizzes') ?? 0;

    final newTotalScore = totalScore + score;
    final newNumOfQuizzes = numOfQuizzes + 1;

    await prefs.setInt('totalScore', newTotalScore);
    await prefs.setInt('numOfQuizzes', newNumOfQuizzes);
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;

    updateBestScore(numCorrectQuestions);

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly',
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionsSummary(summaryData),
            const SizedBox(
              height: 30,
            ),
            TextButton.icon(
              onPressed: onRestart,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Restart Quiz !'),
            )
          ],
        ),
      ),
    );
  }
}
