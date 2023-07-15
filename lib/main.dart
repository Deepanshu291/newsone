import 'package:flutter/material.dart';
import 'package:newsone/Providers/ApiProvider.dart';
import 'package:newsone/Screens/PageViewScreen.dart';
import 'package:newsone/Screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewsApiProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.deepPurple,
          // colorSchemeSeed: Colors.amber
        ),
        home: const Main(),
      ),
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int index = 0;
  List screen =  [Home(), pageview()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // scrolledUnderElevation: 0,

        title: const Text(
          "NewsOne",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
              color: Colors.deepPurple),
        ),
        centerTitle: true,
      ),
      body: screen[index],
      bottomNavigationBar: NavigationBar(
        animationDuration: const Duration(seconds: 2),
        selectedIndex: index,
        onDestinationSelected: (index) => setState(() {
          this.index = index;
        }),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.newspaper), label: "Short")
        ],
      ),
    );
  }
}
