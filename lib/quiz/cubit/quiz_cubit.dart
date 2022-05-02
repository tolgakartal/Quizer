import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quizer/quiz/model/domain/quiz_element.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(const QuizState.loading());

  /// Add a new question, answer pair `QuizElement` to the quiz
  void addQuizElement({
    required String question,
    required String answer,
  }) {
    try {
      state.quizElements.add(QuizElement(question: question, answer: answer));
      emit(QuizState.success(quizElements: state.quizElements));
    } catch (e) {
      emit(const QuizState.failure());
    }
  }
}
