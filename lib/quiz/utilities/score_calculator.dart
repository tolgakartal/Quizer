class ScoreCalculator {
  static const ignoreWordSet = {
    'a',
    'an',
    'the',
    'with',
    ',',
    '.',
    '',
    ' ',
    'from',
    'of',
    'and',
    'or',
    'that',
    'where',
    'which',
    'who',
    'is',
    'are',
    'it'
  };

  /// Calculates the grade by comparing user's answer with the answer from
  /// appropriate String value.
  ///
  /// Grade is calculated by two factors.
  /// First factor is worth 60% of the answer score, it calculates how many of
  /// the keywords are input by the user. A keyword is a word tagged with @ .
  /// The second factor is worth 40% of the score, it calculates the intersection
  /// word amount between the right answer and user's answer. If no tag is
  /// used in the documented answer, then only second factor is taken into account

  static int checkAnswer(
    String userAnswer,
    String correctAnswer,
  ) {
    final answerWithoutSpacesCommas = userAnswer
        .replaceAll(',', '')
        .replaceAll('.', '')
        .toUpperCase()
        .split(' ')
        .toSet();
    final correctAnswerWithoutSpacesCommasTags = correctAnswer
        .replaceAll(',', '')
        .replaceAll('.', '')
        .replaceAll('@', '')
        .toUpperCase()
        .split(' ')
        .toSet();

    correctAnswerWithoutSpacesCommasTags.removeAll(ignoreWordSet);

    final firstFactorScore = _calculateFirstFactorScore(
      userAnswer,
      correctAnswer,
      answerWithoutSpacesCommas,
    );
    final secondFactorScore = _calculateSecondScoreFactor(
      correctAnswerWithoutSpacesCommasTags,
      answerWithoutSpacesCommas,
    );

    int score;
    if (firstFactorScore != 0) {
      score = (firstFactorScore * 0.6 + secondFactorScore * 0.4).toInt();
    } else {
      score = secondFactorScore;
    }

    if (score <= 5) {
      return 0;
    } else if (score <= 20) {
      return 1;
    } else if (score <= 50) {
      return 2;
    } else if (score <= 70) {
      return 3;
    } else if (score <= 84) {
      return 4;
    } else {
      return 5;
    }
  }

  static int _calculateFirstFactorScore(
    String userAnswer,
    String correctAnswerRaw,
    Set<String> answerWithoutSpacesCommas,
  ) {
    var keywords = <String>{};
    var currentCorrectAnswer =
        correctAnswerRaw.toUpperCase().split(' ').toSet();
    currentCorrectAnswer.removeAll(ignoreWordSet);
    currentCorrectAnswer
        .where((x) => x.startsWith('@'))
        .forEach((x) => keywords.add(x.replaceAll('@', '')));

    var firstFactorSharedSet = answerWithoutSpacesCommas.intersection(keywords);
    int firstFactorScore = 0;
    if (keywords.isNotEmpty) {
      firstFactorScore = (firstFactorSharedSet.length * 100) ~/ keywords.length;
    }

    return firstFactorScore;
  }

  static int _calculateSecondScoreFactor(
    Set<String> correctAnswerWithoutSpacesCommasTags,
    Set<String> currentUserAnswer,
  ) {
    var secondFactorSharedSet =
        correctAnswerWithoutSpacesCommasTags.intersection(currentUserAnswer);
    if (correctAnswerWithoutSpacesCommasTags.isEmpty) return 0;
    return (secondFactorSharedSet.length * 100) ~/
        correctAnswerWithoutSpacesCommasTags.length;
  }
}
