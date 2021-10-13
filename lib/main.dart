import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  // ignore: avoid_print
  print('background message ${message.notification!.body}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FirebaseMessaging messaging;

  @override
  void initState() {
    super.initState();

    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) => {
          // ignore: avoid_print
      print(value),
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      // ignore: avoid_print
      print("message recieved");
      // ignore: avoid_print
      print(event.notification!.body);
    });
    
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // ignore: avoid_print
      print('Message clicked!');
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: AppBar(title: const Text("Notify"),),
      body: const Center(child: Text("Welcome"),),
    );
  }
}