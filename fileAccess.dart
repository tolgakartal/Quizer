import 'dart:io';
import 'dart:convert';
import 'package:args/args.dart';

const lineNumber = 'line-number';
String currentQuestion;
String currentAnswer;

ArgResults argResults;

void main(List<String> arguments) {
  exitCode = 0; //presume success
  final parser = new ArgParser()
    ..addFlag(lineNumber, negatable: false, abbr: 'n');

  argResults = parser.parse(arguments);
  List<String> paths = argResults.rest;

  dcat(paths, argResults[lineNumber]);
}

Future<Map<String, String>> dcat(
    List<String> paths, bool showLineNumbers) async {
  if (paths.isEmpty) {
    // No files provided as arguments. Read from stdin and print each line.
    await stdin.pipe(stdout);
  } else {
    for (var path in paths) {
      int lineNumber = 1;
      Stream lines = new File(path)
          .openRead()
          .transform(utf8.decoder)
          .transform(const LineSplitter());
      try {
        Map<String, String> quiz = {};
        bool questionMode;
        bool answerMode;

        await for (var line in lines) {
          if (showLineNumbers) {
            stdout.write('${lineNumber++} ');
          }

          if (line.toString().contains('[Question]') ||
              line.toString().contains('[End]')) {
            if (currentQuestion != null &&
                currentQuestion != "" &&
                currentAnswer != null &&
                currentAnswer != "") {
              quiz.addEntries({new MapEntry(currentQuestion, currentAnswer)});
              currentQuestion = "";
              currentAnswer = "";
            }

            questionMode = true;
            answerMode = false;
            continue;
          }

          if (line.toString().contains('[Answer]')) {
            answerMode = true;
            questionMode = false;
            continue;
          }

          if (questionMode) addQuestion(line);
          if (answerMode) addAnswer(line);
        }

        return await quiz;
      } catch (_) {
        await _handleError(path);
      }
    }
  }
}

void addQuestion(String line) {
  if (line == "") return;

  if (currentQuestion != null && currentQuestion != "") {
    currentQuestion += '\n$line';
  } else {
    currentQuestion = line;
  }
}

void addAnswer(String line) {
  if (line == "") return;

  if (currentAnswer != null && currentAnswer != "") {
    currentAnswer += '\n$line';
  } else {
    currentAnswer = line;
  }
}

Future _handleError(String path) async {
  if (await FileSystemEntity.isDirectory(path)) {
    stderr.writeln('error: $path is a directory');
  } else {
    exitCode = 2;
  }
}