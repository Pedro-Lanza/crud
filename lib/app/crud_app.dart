import 'package:crud/app/pages/form/user_form.dart';
import 'package:crud/app/pages/users_list/user_list.dart';
import 'package:crud/app_routes.dart';
import 'package:flutter/material.dart';

class CrudApp extends StatelessWidget {
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent, brightness: Brightness.dark)),
      debugShowCheckedModeBanner: false,
      home: const UserList(),
      routes: {
        AppRoutes.home: (_) => const UserList(),
        AppRoutes.form: (_) => UserForm(),
      },
    );
  }
}
