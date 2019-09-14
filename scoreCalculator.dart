import 'constants.dart';

class ScoreCalculator {
  Set<String> formattedUserAnswer;
  Set<String> formattedCorrectAnswer;
  Set<String> keywords;

  void setKeywordsInCorrectAnswer(String correctAnswerRaw) {
    keywords = new Set<String>();
    var currentCorrectAnswer =
        correctAnswerRaw.toUpperCase().split(' ').toSet();
    
    currentCorrectAnswer.removeAll(ignoreWordSet);

    currentCorrectAnswer
        .where((x) => x.startsWith('@'))
        .forEach((x) => keywords.add(x.replaceAll('@', '')));
  }

  void formatCorrectAnswer(String correctAnswerRaw) {
    // Hold this variable in the memory to able to calculate
    // the second score factor
    formattedCorrectAnswer =
        correctAnswerRaw.replaceAll('@', '').toUpperCase().split(' ').toSet();
    
    formattedCorrectAnswer.removeAll(ignoreWordSet);
  }

  void formatUserAnswer(String userAnswerRaw) {
    formattedUserAnswer =
        userAnswerRaw.toUpperCase().split(' ').toSet();

    formattedUserAnswer.removeAll(ignoreWordSet);
  }

  int calculateFirstFactorScore(String userAnswer, String correctAnswerRaw) {
    var keywords = new Set<String>();
    formattedUserAnswer = userAnswer
        .replaceAll(',', '')
        .replaceAll('.', '')
        .toUpperCase()
        .split(' ')
        .toSet();
    formattedCorrectAnswer =
        correctAnswerRaw.replaceAll('@', '').toUpperCase().split(' ').toSet();
    var currentCorrectAnswer =
        correctAnswerRaw.toUpperCase().split(' ').toSet();
    currentCorrectAnswer.removeAll(ignoreWordSet);
    currentCorrectAnswer
        .where((x) => x.startsWith('@'))
        .forEach((x) => keywords.add(x.replaceAll('@', '')));

    var firstFactorSharedSet = formattedUserAnswer.intersection(keywords);
    int firstFactorScore;
    if (keywords.length > 0) {
      firstFactorScore = (firstFactorSharedSet.length * 100) ~/ keywords.length;
    }

    return firstFactorScore;
  }
}
