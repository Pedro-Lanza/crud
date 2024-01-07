import 'package:crud/app/data/providers/details_provider.dart';
import 'package:crud/app/data/providers/post_provider.dart';
import 'package:crud/app/data/repository/details_repository.dart';
import 'package:crud/app/data/repository/post_repository.dart';
import 'package:crud/app/pages/details/bloc/details_bloc.dart';
import 'package:crud/app/pages/details/user_profile.dart';
import 'package:crud/app/pages/form/bloc/form_bloc.dart';
import 'package:crud/app/pages/form/user_form.dart';
import 'package:crud/app/pages/users_list/bloc/userslist_bloc.dart';
import 'package:crud/app/pages/users_list/user_list.dart';
import 'package:crud/app/data/providers/user_provider.dart';
import 'package:crud/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crud/app/data/repository/user_repository.dart';

class CrudApp extends StatelessWidget {
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (ctx) => PostProvider(repository: PostRepository())),
        RepositoryProvider(create: (ctx) => DetailsProvider(repository: DetailsRepository(), posts: ctx.read<PostProvider>())),
        RepositoryProvider(create: (ctx) => UserProvider(repository: UserRepository(), details: ctx.read<DetailsProvider>())),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ListBloc>(
            create: (ctx) => ListBloc(provider: ctx.read<UserProvider>()),
          ),
          BlocProvider<FormBloc>(
            create: (ctx) => FormBloc(
              userProvider: ctx.read<UserProvider>(),
              detailsProvider: ctx.read<DetailsProvider>(),
            ),
          ),
          BlocProvider<DetailsBloc>(
            create: (ctx) => DetailsBloc(detailsProvider: ctx.read<DetailsProvider>()),
          ),
          BlocProvider<PostsBloc>(
            create: (ctx) => PostsBloc(postProvider: ctx.read<PostProvider>()),
          )
        ],
        child: MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent, brightness: Brightness.dark),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.home,
          routes: {
            AppRoutes.home: (ctx) => UserList(bloc: ctx.read<ListBloc>()),
            AppRoutes.form: (ctx) => UserForm(bloc: ctx.read<FormBloc>()),
            AppRoutes.details: (ctx) => UserProfile(
                  detailsBloc: ctx.read<DetailsBloc>(),
                  postsBloc: ctx.read<PostsBloc>(),
                ),
          },
        ),
      ),
    );
  }
}
