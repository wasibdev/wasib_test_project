import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:test_project/pages/home_page.dart';
import 'package:test_project/providers/album_provider.dart';
import 'package:test_project/providers/comment_provider.dart';
import 'package:test_project/providers/photos_provider.dart';
import 'package:test_project/providers/post_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark
  ));
  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}
List<SingleChildWidget> providers = [
  ChangeNotifierProvider<AlbumProvider>(create: (_) => AlbumProvider()),
  ChangeNotifierProvider<PhotosProvider>(create: (_) => PhotosProvider()),
  ChangeNotifierProvider<PostProvider>(create: (_) => PostProvider()),
  ChangeNotifierProvider<CommentProvider>(create: (_) => CommentProvider()),
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
