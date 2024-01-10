import 'package:crud/app/crud_app.dart';
import 'package:crud/app/data/providers/details_provider.dart';
import 'package:crud/app/data/providers/post_provider.dart';
import 'package:crud/app/data/providers/user_provider.dart';
import 'package:crud/app/pages/details/bloc/details_bloc.dart';
import 'package:crud/app/pages/form/bloc/form_bloc.dart';
import 'package:crud/app/pages/users_list/bloc/userslist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

final GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  // Hive.registerAdapter(UserAdapter());
  // Hive.registerAdapter(DetailsAdapter());
  // Hive.registerAdapter(PostAdapter());

  // await Hive.openBox<User>('users');
  // await Hive.openBox<Details>('details');
  // await Hive.openBox<Post>('posts');

  /*var userbox =*/ await Hive.openBox<Map<dynamic, dynamic>>('users');
  /*var detailsbox =*/ await Hive.openBox<Map<dynamic, dynamic>>('details');
  /*var postbox =*/ await Hive.openBox<Map<dynamic, dynamic>>('posts');

  // userbox.clear();
  // detailsbox.clear();
  // postbox.clear();

  // userbox.deleteFromDisk();
  // detailsbox.deleteFromDisk();
  // postbox.deleteFromDisk();

  // String path = Directory.current.path;
  // await BoxCollection.open(
  //   'CRUDBoxes', // Name of your database
  //   {'users', 'details', 'posts'}, // Names of your boxes
  // );

  setupGetIt();

  runApp(const CrudApp());
}

void setupGetIt() {
  getIt.registerSingleton<PostProvider>(PostProvider());
  getIt.registerSingleton<DetailsProvider>(DetailsProvider(posts: getIt<PostProvider>()));
  getIt.registerSingleton<UserProvider>(UserProvider(details: getIt<DetailsProvider>()));

  getIt.registerSingleton<ListBloc>(ListBloc(provider: getIt<UserProvider>()));
  getIt.registerFactory<FormBloc>(() => FormBloc(userProvider: getIt<UserProvider>(), detailsProvider: getIt<DetailsProvider>()));
  getIt.registerSingleton<DetailsBloc>(DetailsBloc(detailsProvider: getIt<DetailsProvider>()));
  getIt.registerSingleton<PostsBloc>(PostsBloc(postProvider: getIt<PostProvider>()));
}
