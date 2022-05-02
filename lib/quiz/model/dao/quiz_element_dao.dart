import 'package:hive/hive.dart';

part 'quiz_element_dao.g.dart';

@HiveType(typeId: 0)
class QuizElementDao extends HiveObject {
  QuizElementDao({
    required this.question,
    required this.answer,
  });

  @HiveField(0)
  final String question;
  @HiveField(1)
  final String answer;
}
