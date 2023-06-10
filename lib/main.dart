import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
        child: MaterialApp(
          title: 'Namer App',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          ),
          home: MyHomePage(),
        ),
      );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current; // optimized for performance

    return Scaffold(
      body: Column(
        children: [
          Text('A random AWESOME idea:'), // Example text Change
          BigCard(pair: pair), // Text Widget is now refactored to BigCard
          ElevatedButton(  // Button Widget
            onPressed: () {
              appState.getNext();  // button action
            },
            child: Text('Next'), //button Text
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget { // Created after refactoring Text
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    return Padding( // Wrapped text with Padding
      padding: const EdgeInsets.all(20), // increased Padding for breathing room
      child: Text(pair.asLowerCase),
    );
  }
}
