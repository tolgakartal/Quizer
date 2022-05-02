import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizer_app/quiz/cubit/quiz_cubit.dart';
import 'package:quizer_app/quiz/presentation/theme.dart';

/// A list item which contains three vertical elements below each other
///
/// First is a question text field with icon
/// Second is a answer text field with a add button if `newElement` is true
/// Third is a correct answer text field if showCorrectAnswer flag is true
/// `showCorrectAnswer` flag is an ephemeral state and that is one of the
/// reasons why this widget is stateful. The other reason is widget containing
/// basically only textfields where user can input data.
class QuizerListItem extends StatefulWidget {
  const QuizerListItem({
    Key? key,
    required this.question,
    required this.answer,
    this.correctAnswer,
    this.newElement = false,
  }) : super(key: key);

  final String question;
  final String answer;
  final String? correctAnswer;
  final bool newElement;

  @override
  State<QuizerListItem> createState() => _QuizerListItemState();
}

class _QuizerListItemState extends State<QuizerListItem> {
  TextEditingController answerController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  TextEditingController correctAnswerController = TextEditingController();
  bool showCorrectAnswer = false;

  @override
  void initState() {
    if (!widget.newElement) {
      questionController.text = widget.question;
      correctAnswerController.text = widget.correctAnswer ?? '';
    }
    super.initState();
  }

  @override
  void dispose() {
    answerController.dispose();
    questionController.dispose();
    correctAnswerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: QuizerTheme.defaultInset,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Vertical spacer
            QuizerTheme.defaultVerticalSpacer,

            /// Question box for user to input
            TextField(
              controller: questionController,
              decoration: QuizerTheme.defaultTextFieldDecoration.copyWith(
                labelText: 'Question',
                prefixIcon: const Icon(Icons.question_mark),
              ),
              maxLines: 3,
              minLines: 1,
            ),

            /// Vertical spacer
            const SizedBox(height: 12),

            /// Answer box for user to input
            TextField(
              controller: answerController,
              decoration: QuizerTheme.defaultTextFieldDecoration.copyWith(
                labelText: widget.newElement ? 'The answer' : 'Your answer',
                prefixIcon: const Icon(Icons.question_answer),

                /// If list item is a new element then suffix icon action
                /// adds the new question and answer to the datastore
                /// else it displays show or hide the actual answer
                suffixIcon: widget.newElement
                    ? IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          /// Add new quiz element to datastore
                          context.read<QuizCubit>().addQuizElement(
                                question: questionController.text,
                                answer: answerController.text,
                              );

                          /// Fetch all quiz elements from datastore
                          context.read<QuizCubit>().fetchQuizElements();
                        },
                      )
                    : IconButton(
                        icon: Icon(showCorrectAnswer
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          showCorrectAnswer = !showCorrectAnswer;
                          setState(() {});
                        },
                      ),
              ),
              maxLines: 3,
              minLines: 1,
            ),

            /// Vertical spacer
            QuizerTheme.defaultVerticalSpacer,

            /// The correct answer
            if (!widget.newElement && showCorrectAnswer)
              TextField(
                decoration: QuizerTheme.defaultTextFieldDecoration.copyWith(
                  labelText: 'correct answer',
                  prefixIcon: const Icon(Icons.check_outlined),
                ),
                controller: correctAnswerController,
                maxLines: 3,
                minLines: 1,
              ),

            /// Vertical spacer
            QuizerTheme.defaultVerticalSpacer,
          ],
        ),
      ),
    );
  }
}
