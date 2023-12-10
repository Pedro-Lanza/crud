import 'package:crud/app/crud_app.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

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

  var userbox = await Hive.openBox<Map<dynamic, dynamic>>('users');
  var detailsbox = await Hive.openBox<Map<dynamic, dynamic>>('details');
  var postbox = await Hive.openBox<Map<dynamic, dynamic>>('posts');

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

  runApp(const CrudApp());
}
