import 'dart:io';
import 'package:args/args.dart';
import 'fileAccess.dart';
import 'constants.dart';
import 'scoreCalculator.dart';

ArgResults argResults;
Set<String> currentUserAnswer;
Set<String> correctAnswerWithoutTags;
bool canShowAnswers;

int calculateFirstFactorScore(String userAnswer, String correctAnswerRaw) {
  var scoreCalculator = new ScoreCalculator();

  scoreCalculator.setKeywordsInCorrectAnswer(correctAnswerRaw);
  scoreCalculator.formatCorrectAnswer(correctAnswerRaw);
  scoreCalculator.formatUserAnswer(userAnswer);

  var keywords = new Set<String>();
  currentUserAnswer = userAnswer
      .replaceAll(',', '')
      .replaceAll('.', '')
      .toUpperCase()
      .split(' ')
      .toSet();
  correctAnswerWithoutTags =
      correctAnswerRaw.replaceAll('@', '').toUpperCase().split(' ').toSet();
  var currentCorrectAnswer = correctAnswerRaw.toUpperCase().split(' ').toSet();
  currentCorrectAnswer.removeAll(ignoreWordSet);
  currentCorrectAnswer
      .where((x) => x.startsWith('@'))
      .forEach((x) => keywords.add(x.replaceAll('@', '')));

  var firstFactorSharedSet = currentUserAnswer.intersection(keywords);
  int firstFactorScore;
  if (keywords.length > 0) {
    firstFactorScore = (firstFactorSharedSet.length * 100) ~/ keywords.length;
  }

  return firstFactorScore;
}

int calculateSecondScoreFactor() {
  var secondFactorSharedSet =
      correctAnswerWithoutTags.intersection(currentUserAnswer);

  return (secondFactorSharedSet.length * 100) ~/
      correctAnswerWithoutTags.length;
}

/// Calculates the grade by comparing user's answer with the answer from
/// appropriate String value. Grade is calculated by two factors. First
/// factor is worth 60% of the answer score, it calculates how many of
/// the keywords are input by the user. A keyword is a word tagged with @ .
/// The second factor is worth 40% of the score, it calculates the intersection
/// word amount between the right answer and user's answer. If no tag is
/// used in the documented answer, then only second factor is taken into account
bool checkAnswer(String correctAnswer, String usersAnswer) {
  var firstFactorScore = calculateFirstFactorScore(usersAnswer, correctAnswer);
  var secondFactorScore = calculateSecondScoreFactor();

  int score;
  if (firstFactorScore != null) {
    score = (firstFactorScore * 0.6 + secondFactorScore * 0.4).toInt();
  } else {
    score = secondFactorScore;
  }

  if (score > 45) {
    print("\n   Good answer ! You've got $score%");
    return true;
  }

  print("\n   Wrong answer :( Your grade is $score%");
  return false;
}

void askAQuestion(String question, String answer) {
  String usersAnswer;
  var correctAnswerWithoutTags = answer.replaceAll('@', '');
  print('\n------------------------------------------------------------');
  print('[Question] $question');
  stdout.write('   Your answer: ');
  usersAnswer = stdin.readLineSync();
  checkAnswer(answer, usersAnswer);
  if (canShowAnswers) {
    print('\n[Answer] $correctAnswerWithoutTags');
  }
  print('------------------------------------------------------------');
}

Future main(List<String> arguments) async {
  final parser = new ArgParser()
    ..addFlag(showAnswers, negatable: false, abbr: 's');

  argResults = parser.parse(arguments);
  List<String> path = argResults.rest;
  var quiz = await dcat(path, false);

  canShowAnswers = argResults.arguments.contains(showAnswers);
  var questionLength = quiz.entries.length;

  print(
      '\nThe file you have imported contains $questionLength questions. \nDo you want to start now ? Y/N');

  stdin.echoMode = false;
  var input = stdin.readLineSync();
  stdin.echoMode = true;
  if (input.toUpperCase() == 'Y') {
    for (var entry in quiz.entries) {
      askAQuestion(entry.key, entry.value);
    }
  }
}
