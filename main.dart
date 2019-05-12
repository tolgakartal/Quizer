import 'dart:io';
import 'package:args/args.dart';
import 'dartvm.dart';

ArgResults argResults;
const showAnswers = 'show-answers';
bool canShowAnswers;

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

void dartVmTest() {
  print('\n*** Welcome to DART VM test ! ***');
  print('\n[Question] What is ARM mean ?');
  var usersAnswer = stdin.readLineSync();

  checkAnswer(arm, usersAnswer);

  if (canShowAnswers) {
    print('\n[Answer]\n\t$arm');
  }
}

bool checkAnswer(String answer, String usersAnswer){
  var answerWords = answer.split(" ").toSet();
  var usersAnswerWords = usersAnswer.split(" ").toSet();
  var answerWordCount = answerWords.length;  

  var sharedWords = answerWords.intersection(usersAnswerWords);
  var sharedWordCount = sharedWords.length;
  var grade = (sharedWordCount * 100) ~/ answerWordCount;
  
  if (grade > 45){
    print("\n!!! Good answer !!! You've got $grade%");
    return true;
  }
  else{
    print("\n:( Wrong answer :( Your grade is $grade%");
    return false;
  }
}