import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizer_app/quiz/cubit/quiz_cubit.dart';
import 'package:quizer_app/quiz/presentation/quizer_list_item.dart';

class QuizerList extends StatelessWidget {
  const QuizerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<QuizCubit>().state;

    switch (state.status) {

      /// Loading State
      case ListStatus.loading:
        return const Center(child: CircularProgressIndicator());

      /// Success State
      case ListStatus.success:
        return Column(
          children: [
            /// Vertical spacer
            const SizedBox(height: 6.0),

            /// New quiz element
            const QuizerListItem(
              question: '',
              answer: '',
              newElement: true,
            ),

            /// Quiz list
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                  itemBuilder: (context, index) => QuizerListItem(
                    question: state.quizElements[index].question,
                    answer: '',
                    correctAnswer: state.quizElements[index].answer,
                  ),
                  itemCount: state.quizElements.length,
                ),
              ),
            ),

            /// Vertical spacer
            const SizedBox(
              height: 12,
            ),
          ],
        );

      /// Failure State
      case ListStatus.failure:
        return const Center(child: Text('Something went wrong'));

      /// Unknown State
      default:
        return const Center(child: Text('Unknown Quiz'));
    }
  }
}
