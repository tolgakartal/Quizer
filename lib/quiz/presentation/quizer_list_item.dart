import 'package:flutter/material.dart';
import 'package:quizer_app/quiz/presentation/theme.dart';

class QuizerListItem extends StatelessWidget {
  const QuizerListItem({
    Key? key,
    required this.question,
    required this.answer,
    this.newElement = false,
  }) : super(key: key);

  final String question;
  final String answer;
  final bool newElement;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: QuizerTheme.defaultInset,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Vertical spacer
          QuizerTheme.defaultVerticalSpacer,

          /// Question box for user to input
          TextField(
            decoration: QuizerTheme.defaultTextFieldDecoration.copyWith(
              labelText: 'Question',
              prefixIcon: const Icon(Icons.question_mark),
            ),
          ),

          /// Vertical spacer
          QuizerTheme.defaultVerticalSpacer,

          /// Answer box for user to input
          TextField(
            decoration: QuizerTheme.defaultTextFieldDecoration.copyWith(
              labelText: newElement ? 'The answer' : 'Your answer',
              prefixIcon: const Icon(Icons.question_answer),

              /// If list item is a new element then suffix icon action
              /// adds the new question and answer to the datastore
              /// else it displays show or hide the actual answer
              suffixIcon: newElement
                  ? IconButton(
                      icon: const Icon(
                        Icons.add,
                      ),
                      onPressed: () {},
                    )
                  : IconButton(
                      icon: const Icon(
                        Icons.visibility,
                      ),
                      onPressed: () {},
                    ),
            ),
          ),

          /// Vertical spacer
          QuizerTheme.defaultVerticalSpacer,
        ],
      ),
    );
  }
}
