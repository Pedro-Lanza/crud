import 'package:crud/app/data/repository/details_repository.dart';
import 'package:crud/app/data/repository/post_repository.dart';
import 'package:crud/app/pages/details/user_profile.dart';
import 'package:crud/app/pages/form/user_form.dart';
import 'package:crud/app/pages/users_list/user_list.dart';
import 'package:crud/app/data/providers/details_provider.dart';
import 'package:crud/app/data/providers/post_provider.dart';
import 'package:crud/app/data/providers/user_provider.dart';
import 'package:crud/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crud/app/data/repository/user_repository.dart';

class CrudApp extends StatelessWidget {
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => PostProvider(
            repository: PostRepository(),
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => DetailsProvider(
            repository: DetailsRepository(),
            posts: Provider.of<PostProvider>(ctx, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => UserProvider(
            repository: UserRepository(),
            details: Provider.of<DetailsProvider>(ctx, listen: false),
          ),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent, brightness: Brightness.dark),
        ),
        debugShowCheckedModeBanner: false,
        home: const UserList(),
        routes: {
          AppRoutes.home: (_) => const UserList(),
          AppRoutes.form: (_) => const UserForm(),
          AppRoutes.details: (_) => const UserProfile(),
        },
      ),
    );
  }
}
