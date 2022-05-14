import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizer_app/quiz/cubit/quiz_cubit.dart';
import 'package:quizer_app/quiz/presentation/theme.dart';
import 'package:quizer_app/quiz/utilities/score_calculator.dart';
import 'package:quizer_app/quiz/utilities/text_field_validator.dart';

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
    required this.index,
    this.correctAnswer,
    this.newElement = false,
  }) : super(key: key);

  final String question;
  final String answer;
  final String? correctAnswer;
  final bool newElement;
  final int index;

  @override
  State<QuizerListItem> createState() => _QuizerListItemState();
}

class _QuizerListItemState extends State<QuizerListItem> {
  TextEditingController answerController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  TextEditingController correctAnswerController = TextEditingController();
  late TextFieldRequiredValidator questionRequiredValidator;
  late TextFieldRequiredValidator answerRequiredValidator;
  bool showCorrectAnswer = false;
  int rating = 0;

  @override
  void initState() {
    if (!widget.newElement) {
      questionController.text = widget.question;
      correctAnswerController.text = widget.correctAnswer ?? '';
    } else {
      questionRequiredValidator = TextFieldRequiredValidator(
        validationMessage: 'Question is required!',
        controller: questionController,
      );
      answerRequiredValidator = TextFieldRequiredValidator(
        validationMessage: 'Answer is required!',
        controller: answerController,
      );
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
                          /// Validate first

                          if (!questionRequiredValidator.validate() ||
                              !answerRequiredValidator.validate()) {
                            return;
                          }

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
              onChanged: (value) {
                rating = ScoreCalculator.checkAnswer(
                  value,
                  correctAnswerController.text,
                );
                setState(() {});
              },
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

            /// Rating and Delete button panel
            if (!widget.newElement)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Rating panel
                  Container(
                    padding: const EdgeInsets.only(top: 4, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (rating != 0) const Text('Your score'),
                        const SizedBox(
                          width: 12,
                        ),
                        for (var i = 0; i < rating; i++) const Icon(Icons.star)
                      ],
                    ),
                  ),

                  /// Delete button
                  TextButton(
                    onPressed: () {
                      /// Delete quiz element in the datastore
                      context.read<QuizCubit>().deleteQuizElement(
                            question: widget.question,
                          );

                      /// Fetch and refresh all quiz elements from datastore
                      context.read<QuizCubit>().fetchQuizElements();
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
