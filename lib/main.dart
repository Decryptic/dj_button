import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  static const String _title = 'DJ Button'; 

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: _title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   //credit to: https://stackoverflow.com/questions/71220577/long-press-time-consider-for-gesturedetector
   late Timer _timer;
   bool _isBlue = true;
 
   void _startHorn() {
     //_timer = Timer(const Duration(milliseconds: 200), () {
       print('Playing horn');
       setState(() => _isBlue = false);
   }
 
   Widget _horn256() {
     return GestureDetector(
       onTapUp: (ds) {
           //_timer.cancel();
           setState(() => _isBlue = true);
       },
       child: Container(
         width: 128,
         height: 128,
         decoration: BoxDecoration(
           shape: BoxShape.circle,
           image: DecorationImage(
             image: AssetImage('assets/images/horn_256.jpeg'),
             fit: BoxFit.fill,
           ),
         ),
       ),
     );
   }

  Widget _horn256_inv() {
     return GestureDetector(
       onTapDown: (ds) {
         setState(() => _isBlue = false);
       },
       child: Container(
         width: 128,
         height: 128,
         decoration: BoxDecoration(
           shape: BoxShape.circle,
           image: DecorationImage(
             image: AssetImage('assets/images/horn_256_inv.jpeg'),
             fit: BoxFit.fill,
           ),
         ),
       ),
     );
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            (_isBlue ? _horn256_inv() : _horn256())
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton( //share
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
