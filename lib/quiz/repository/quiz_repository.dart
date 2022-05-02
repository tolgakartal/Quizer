import 'package:hive/hive.dart';
import 'package:quizer/quiz/model/dao/quiz_element_dao.dart';

class QuizRepository {
  static const cacheBoxName = 'quizer_box';
  void addQuizElement({
    required String question,
    required String answer,
  }) async {
    final box = await Hive.openBox(cacheBoxName);
    box.add(QuizElementDao(
      question: question,
      answer: answer,
    ));
  }
}
