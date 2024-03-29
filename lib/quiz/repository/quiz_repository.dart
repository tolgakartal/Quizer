import 'package:hive/hive.dart';
import 'package:quizer_app/quiz/model/dao/quiz_element_dao.dart';
import 'package:quizer_app/quiz/model/domain/quiz_element.dart';

class QuizRepository {
  static const cacheBoxName = 'quizer_box';

  void addQuizElement({
    required String question,
    required String answer,
  }) async {
    final box = await prepareDatastore();
    box.add(QuizElementDao(
      question: question,
      answer: answer,
    ));
  }

  void deleteQuizElement({
    required String question,
  }) async {
    final box = await prepareDatastore();
    final deletingElement = box.values.firstWhere(
        (element) => element is QuizElementDao && element.question == question);
    if (deletingElement.key != null) {
      box.delete(deletingElement.key);
    }
  }

  Future<List<QuizElement>> fetchQuizElements() async {
    final box = await prepareDatastore();
    final List<QuizElementDao> quizElementsDao =
        box.values.cast<QuizElementDao>().toList();

    return quizElementsDao
        .map(
          (e) => QuizElement(
            question: e.question,
            answer: e.answer,
          ),
        )
        .toList();
  }

  Future<Box<dynamic>> prepareDatastore() async {
    if (!Hive.isBoxOpen(cacheBoxName)) {
      return await Hive.openBox<QuizElementDao>(cacheBoxName);
    }

    return Hive.box<QuizElementDao>(cacheBoxName);
  }
}
