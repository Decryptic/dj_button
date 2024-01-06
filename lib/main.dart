import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

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
   //https://stackoverflow.com/questions/71220577/long-press-time-consider-for-gesturedetector
   //late Timer _timer;
   AudioPlayer _player = AudioPlayer();
   bool _isBlue = true;
 
   void _startHorn() async {
     //_timer = Timer(const Duration(milliseconds: 200), () {
       //await _player.stop();
       print('Playing horn');
       setState(() => _isBlue = false);
       await AudioPlayer.clearAssetCache();
       await _player.setAsset('assets/sounds/airhorn-sfx.mp3');
       await _player.play();
   }
   
   void _stopHorn() async {
       print('Stopping horn');
       setState(() => _isBlue = true);
       await _player.stop();
   }
 
   Widget _horn256() {
     return GestureDetector(
       onTapUp: (ds) {
           //_timer.cancel();
           setState(() => _isBlue = true);
           //_stopHorn();
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
         //setState(() => _isBlue = false);
         _startHorn();
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
    );
  }
}
