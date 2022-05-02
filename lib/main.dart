import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quizer/quiz/model/domain/quiz_element.dart';
import 'package:quizer/quiz/presentation/quizer_list.dart';
import 'package:quizer/quiz/repository/quiz_repository.dart';

void main() async {
  /// Prepare quiz datastore for consumption
  await Hive.initFlutter();
  //Hive.registerAdapter(QuizElementAdapter());
  await Hive.openBox<QuizElement>(QuizRepository.cacheBoxName);

  /// Once datastore ready then run the app
  runApp(const QuizerApp());
}

class QuizerApp extends StatelessWidget {
  const QuizerApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizer',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.amber,
      ),
      home: const QuizerList(),
    );
  }
}
