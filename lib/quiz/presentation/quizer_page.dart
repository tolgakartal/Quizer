import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizer_app/quiz/cubit/quiz_cubit.dart';
import 'package:quizer_app/quiz/presentation/quizer_list.dart';
import 'package:quizer_app/quiz/repository/quiz_repository.dart';

class QuizerPage extends StatelessWidget {
  const QuizerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Platform.isIOS || Platform.isAndroid
          ? AppBar(title: const Text('QuizerApp'))
          : null,
      backgroundColor: Colors.grey[200],
      body: BlocProvider(
        create: (_) => QuizCubit(
          repository: context.read<QuizRepository>(),
        )..fetchQuizElements(),
        child: const QuizerList(),
      ),
    );
  }
}
