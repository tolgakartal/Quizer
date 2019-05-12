import 'dart:io';
import 'package:args/args.dart';
import 'dartvm.dart';

ArgResults argResults;
const showAnswers = 'show-answers';
bool canShowAnswers;
final ignoreWordSet = [
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
].toSet();
Set<String> currentUserAnswer;
Set<String> currentCorrectAnswerWithoutTags;

int calculateFirstFactorScore(String userAnswer, String correctAnswerRaw) {
  var keywords = new Set<String>();
  currentUserAnswer = userAnswer.toUpperCase().split(' ').toSet();
  currentCorrectAnswerWithoutTags =
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
      currentCorrectAnswerWithoutTags.intersection(currentUserAnswer);

  return (secondFactorSharedSet.length * 100) ~/
      currentCorrectAnswerWithoutTags.length;
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

void dartVmTest() {
  print('\n[1] Dart Vm test has chosen');

  askAQuestion(whatIsArmQuestion, whatIsArmAnswer);
  askAQuestion(whenArm64BitQuestion, whenArm64BitAnswer);
  askAQuestion(armMainDifferenceQuestion, armMainDifferenceAnswer);
}

void main(List<String> arguments) {
  final parser = new ArgParser()
    ..addFlag(showAnswers, negatable: false, abbr: 's');

  argResults = parser.parse(arguments);
  argResults[showAnswers];
  canShowAnswers = argResults.arguments.contains(showAnswers);

  print('\n[1] Start dart VM test');
  print('[2] Start dart AOT test');
  stdin.echoMode = false;
  var input = stdin.readLineSync();
  stdin.echoMode = true;
  if (input.toUpperCase() == '1') {
    dartVmTest();
  }
}
