import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Define the start screen of the quiz, with the logo and the start button

class StartScreen extends StatefulWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  StartScreenState createState() => StartScreenState();
}

class StartScreenState extends State<StartScreen> {
  int bestScore = 0;

  @override
  void initState() {
    super.initState();
    loadBestScore();
  }

  Future<void> loadBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      bestScore = prefs.getInt('bestScore') ?? 0;
    });
  }

  Future<double> getAverageScore() async {
    final prefs = await SharedPreferences.getInstance();
    final totalScore = prefs.getInt('totalScore') ?? 0;
    final numOfQuizzes = prefs.getInt('numOfQuizzes') ?? 0;

    if (numOfQuizzes == 0) {
      return 0.0; // Retourne 0 si aucun quiz n'a été joué
    }

    return totalScore / numOfQuizzes;
  }

  @override
  Widget build(context) {
    return FutureBuilder<double>(
        future: getAverageScore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Indicateur de chargement
          }

          final averageScore = snapshot.data ?? 0.0;

          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/quiz-logo.png',
                  width: 300,
                  color: const Color.fromARGB(150, 255, 255, 255),
                ),
                const SizedBox(height: 80),
                Text(
                  'Learn Flutter the fun way !',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                ),
                const SizedBox(height: 30),
                OutlinedButton.icon(
                  onPressed: () {
                    widget.startQuiz();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Start Quiz'),
                ),
                const SizedBox(height: 35),
                Text(
                  'Best Score: $bestScore',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Average Score: ${averageScore.toStringAsFixed(2)}',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
