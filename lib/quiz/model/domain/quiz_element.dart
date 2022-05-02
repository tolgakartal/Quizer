import 'package:equatable/equatable.dart';

class QuizElement extends Equatable {
  const QuizElement({
    required this.question,
    required this.answer,
  });

  final String question;
  final String answer;

  QuizElement copyWith({String? question, String? answer}) {
    return QuizElement(
      question: question ?? this.question,
      answer: answer ?? this.answer,
    );
  }

  @override
  List<Object?> get props => [
        question,
        answer,
      ];
}
