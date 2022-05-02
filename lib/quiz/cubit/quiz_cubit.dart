import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quizer_app/quiz/model/domain/quiz_element.dart';
import 'package:quizer_app/quiz/repository/quiz_repository.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit({required this.repository}) : super(const QuizState.loading());

  final QuizRepository repository;

  /// Fetch all quiz elements
  Future<void> fetchQuizElements() async {
    try {
      final quizElements = await repository.fetchQuizElements();
      emit(QuizState.success(quizElements: quizElements));
    } on Exception {
      emit(const QuizState.failure());
    }
  }

  /// Add a new question, answer pair `QuizElement` to the quiz
  void addQuizElement({
    required String question,
    required String answer,
  }) {
    try {
      repository.addQuizElement(
        question: question,
        answer: answer,
      );
      emit(QuizState.success(quizElements: state.quizElements));
    } catch (e) {
      emit(const QuizState.failure());
    }
  }
}
