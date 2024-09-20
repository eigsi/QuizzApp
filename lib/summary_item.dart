import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz_app/question_identifier.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem(this.itemData, {super.key});

  final Map<String, Object> itemData;

// This widget displays a question and the user's answer to it, with also the question identifier.

  @override
  Widget build(BuildContext context) {
    final isCorrectAnswer =
        itemData['user_answer'] == itemData['correct_answer'];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuestionIdentifier(
          isCorrectAnswer: isCorrectAnswer,
          questionIndex: itemData['question_index'] as int,
        ),
        const SizedBox(width: 20),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              itemData['question'] as String,
              style: GoogleFonts.lato(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              itemData['user_answer'] as String,
              style: const TextStyle(
                color: Color.fromARGB(255, 24, 6, 66),
              ),
            ),
            Text(
              itemData['correct_answer'] as String,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ))
      ],
    );
  }
}
