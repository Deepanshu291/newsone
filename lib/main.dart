import 'package:flutter/material.dart';
import 'package:newsone/Screens/PageViewScreen.dart';
import 'package:newsone/Screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,


        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
        // colorSchemeSeed: Colors.amber
      ),
      home: const Main(),
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
  List screen = const [ Home(), pageview()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        // scrolledUnderElevation: 0,
        
        title: const Text("NewsOne",style: TextStyle(fontWeight: FontWeight.w600,letterSpacing: 2,color: Colors.deepPurple),),
        centerTitle: true,
      ),
      body: screen[index],

      bottomNavigationBar: NavigationBar(
        animationDuration:const Duration(seconds: 2),
        selectedIndex: index,
        onDestinationSelected: (index) => setState(() {
          this.index = index;
        }),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations:const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.newspaper), label: "Short")
        ],
      ),
    );
  }
}
