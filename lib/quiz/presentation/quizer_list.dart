import 'package:flutter/material.dart';
import 'package:quizer/quiz/cubit/quiz_cubit.dart';
import 'package:quizer/quiz/presentation/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        return ListView.builder(
          itemBuilder: (context, index) => Container(
            padding: QuizerTheme.defaultInset,
            child: Column(
              children: [
                /// Question title
                const Text('Question'),

                /// Question row
                Row(
                  children: [
                    /// Question icon
                    const Icon(Icons.question_mark),

                    /// Horizontal spacer
                    const SizedBox(width: 12),

                    /// Question text
                    Text(state.quizElements[index].question),
                  ],
                ),

                /// Vertical spacer
                QuizerTheme.defaultVerticalSpacer,

                /// Answer box for user to input
                TextField(
                  decoration: QuizerTheme.defaultTextFieldDecoration
                      .copyWith(labelText: 'Your answer'),
                ),

                /// Vertical spacer
                QuizerTheme.defaultVerticalSpacer,

                /// Icon to show or hide the answer
                IconButton(
                  icon: const Icon(
                    Icons.visibility_off,
                  ),
                  onPressed: () {},
                ),

                /// Vertical spacer
                QuizerTheme.defaultVerticalSpacer,

                /// Correct answer title
                const Text('Correct answer'),

                /// Vertical spacer
                QuizerTheme.defaultVerticalSpacer,

                /// Answer text
                Text(state.quizElements[index].answer),
              ],
            ),
          ),
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
