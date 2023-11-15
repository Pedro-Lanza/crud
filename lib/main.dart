import 'dart:io';

import 'package:crud/app/crud_app.dart';
import 'package:crud/app/models/details_entity.dart';
import 'package:crud/app/models/posts_entity.dart';
import 'package:crud/app/models/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(DetailsAdapter());
  Hive.registerAdapter(PostAdapter());

  var userbox = await Hive.openBox<User>('users');
  var detailsbox = await Hive.openBox<Details>('details');
  var postbox = await Hive.openBox<Post>('posts');

  userbox.clear();
  detailsbox.clear();
  postbox.clear();

  // String path = Directory.current.path;
  // await BoxCollection.open(
  //   'CRUDBoxes', // Name of your database
  //   {'users', 'details', 'posts'}, // Names of your boxes
  // );

  runApp(const CrudApp());
}
