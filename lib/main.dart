import 'dart:ui';

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
            colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 10, 236, 165)), // ColorScheme for entire app
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
      body: Center( // Center wrapped Column for centering the UI
        child: Column( // wraped with Center for center the UI
          mainAxisAlignment: MainAxisAlignment.center, // Overriding the children being lumped to the top. This centers the children inside the Column along its main (vertical) axis.
          children: [
            BigCard(pair: pair), // Text Widget is now refactored to BigCard
            SizedBox(height: 10),
            ElevatedButton(  // Button Widget
              onPressed: () {
                appState.getNext();  // button action
              },
              child: Text('Next'), //button Text
            ),
          ],
        ),
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
    final theme = Theme.of(context); // Requests the apps current theme
    final style = theme.textTheme.displayMedium!.copyWith( // Access the font theme wiht theme.textTheme and displayMedium large style meant for display text
      color: theme.colorScheme.onPrimary, // the displayMedium could theoretically be null. Dart is null safe, so it won't let you call methods of objects that are potentially null. In this case, though you can use the ! operator ("bang operator) to assure Dart you know what you're doing.
    ); // Calling copy with on displayMedium returns a copy of the text style with the changes you define. In this case, you're only changing the text color.
       // to get the new color, you once again access the app's theme. The color scheme's onPrimary property defines a color that is a good fit for use on the app's primary color.
    return Card( // type was changed to "Card" with wrap with widget
      color: theme.colorScheme.primary,
      child: Padding( // Wrapped text with Padding //Wrapped with widget
        padding: const EdgeInsets.all(20), // increased Padding for breathing room
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}", // Improves accesiblity of visually impaired improves screen reader.
        ),
      ),
    );
  }
}
