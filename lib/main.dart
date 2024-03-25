import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest/api/bloc/api_bloc.dart';
import 'package:fluttertest/api/ui.dart';
import 'package:fluttertest/counterapp/bloc/counter_bloc.dart';
import 'package:fluttertest/counterapp/ui.dart';
import 'package:fluttertest/api_calling%20normal/todo_list.dart';

void main() {
  runApp(myapp());
}

class myapp extends StatelessWidget {
  const myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApisBloc(),
      child: MaterialApp(
        home: HomepageApi(),
      ),
    );
  }
}
