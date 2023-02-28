import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';

import 'cats.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
    Widget build(BuildContext context) {
      return MaterialApp(
          title: 'ezcats',
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            colorScheme: const ColorScheme.dark(
              primary: Colors.deepOrange,
              secondary:  Colors.deepOrange,
              ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            brightness: Brightness.dark,
            ),
          home: Home(getCats()),
        );
    }
}

Future<Image> getCatImage() async {
  Uint8List? bytes = await getCatData();
  return Image.memory(bytes!);
}

List<Future<Image>> getCats([int limit=10]) {
  List<Future<Image>> cats = [];
  for (int i=0; i<limit; i++) {
    cats.add(getCatImage());
  }
  return cats;
}

class Home extends StatefulWidget {
  final List<Future<Image>> cats;
  const Home(this.cats, {Key? key}) : super(key: key);

  @override
    State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Image? currentCat;
  void updateCat() {
    widget.cats.removeAt(0).then((cat) {
      currentCat = cat;
    });
    widget.cats.add(getCatImage());
  }

  final initial = const Padding(
    padding: EdgeInsets.all(8),
    child: Text("Click the + icon to see a cute cat!",
      style: TextStyle(fontSize: 36),
      softWrap: true,
      textAlign: TextAlign.center)
  );

  @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            leading: const Icon(Icons.computer),
            title: const Text("ezcats"),
            ),
          body: Center(
            child: currentCat ?? initial,
            ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => setState(() => updateCat()),
            ),
          );
    }
}
