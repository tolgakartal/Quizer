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

bool checkAnswer(String answer, String usersAnswer) {
  var answerWords = answer.toUpperCase().split(" ").toSet();
  answerWords.removeAll(ignoreWordSet);
  var usersAnswerWords = usersAnswer.toUpperCase().split(" ").toSet();
  var answerWordCount = answerWords.length;

  var sharedWords = answerWords.intersection(usersAnswerWords);
  var sharedWordCount = sharedWords.length;
  var grade = (sharedWordCount * 100) ~/ answerWordCount;

  if (grade > 45) {
    print("\n   Good answer ! You've got $grade%");
    return true;
  } else {
    print("\n   Wrong answer :( Your grade is $grade%");
    return false;
  }
}

void askAQuestion(String question, String answer) {
  String usersAnswer;
  print('\n------------------------------------------------------------');
  print('[Question] $question');
  stdout.write('   Your answer: ');
  usersAnswer = stdin.readLineSync();
  if (canShowAnswers) {
    print('\n[Answer] $answer');
  }
  checkAnswer(whatIsArmAnswer, usersAnswer);
  print('------------------------------------------------------------');
}

void dartVmTest() {
  print('\n*** Welcome to DART VM test ! ***');

  askAQuestion(whatIsArmQuestion, whatIsArmAnswer);
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
