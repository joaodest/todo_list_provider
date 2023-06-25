import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:todo_list_provider/app/core/modules/auth/auth_module.dart';

import 'package:todo_list_provider/app/core/database/sqlite_adm_connection.dart';

import 'package:todo_list_provider/app/core/splash/splash_page.dart';
import 'package:todo_list_provider/app/core/ui/todo_list_ui_config.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final sqliteAdmConnection = SqliteAdmConnection();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(sqliteAdmConnection);
    FirebaseAuth auth = FirebaseAuth.instance;
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(sqliteAdmConnection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: TodoListUiConfig.theme,
      title: 'Todo List Provider',
      initialRoute: '/login',
      routes: {
        ...AuthModule().routers,
      },
      home: SplashPage(),
    );
  }
}
