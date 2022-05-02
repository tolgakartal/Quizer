part of 'quiz_cubit.dart';

enum ListStatus { loading, success, failure }

class QuizState extends Equatable {
  /// Private ctor which is called by the named ctors
  /// This approach facilitates reducing the amount of classes
  /// for each type of the `QuizState`
  const QuizState._({
    this.status = ListStatus.loading,
    this.quizElements = const [],
  });

  /// Loading state which does not change quiz elements list
  /// it serves to change the list status as `ListStatus.loading`
  const QuizState.loading() : this._(status: ListStatus.loading);

  /// Update quiz elements in the list
  /// it also serves to change the list status as `ListStatus.success`
  const QuizState.success({required List<QuizElement> quizElements})
      : this._(
          status: ListStatus.success,
          quizElements: quizElements,
        );

  /// List status will not change, this ctor only serves
  /// to change the list status as `ListStatus.failure`
  const QuizState.failure() : this._(status: ListStatus.failure);

  final List<QuizElement> quizElements;
  final ListStatus status;

  @override
  List<Object?> get props => [quizElements, status];
}
