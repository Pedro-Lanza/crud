import 'package:crud/app/pages/details/user_profile.dart';
import 'package:crud/app/pages/form/user_form.dart';
import 'package:crud/app/pages/users_list/user_list.dart';
import 'package:crud/app/providers/details_provider.dart';
import 'package:crud/app/providers/post_provider.dart';
import 'package:crud/app/providers/user_provider.dart';
import 'package:crud/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CrudApp extends StatelessWidget {
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
        ChangeNotifierProvider(create: (ctx) => DetailsProvider()),
        ChangeNotifierProvider(create: (ctx) => PostProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent, brightness: Brightness.dark)),
        debugShowCheckedModeBanner: false,
        home: const UserList(),
        routes: {
          AppRoutes.home: (_) => const UserList(),
          AppRoutes.form: (_) => UserForm(),
          AppRoutes.details: (_) => UserProfile(),
        },
      ),
    );
  }
}
