import 'package:chatapp/functions/db_functions.dart';
import 'package:chatapp/models/chat_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

initialization()async{
  WidgetsFlutterBinding.ensureInitialized();
  Future<void> initializeFirebase() async {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "YOUR_API_KEY",
          authDomain: "YOUR_AUTH_DOMAIN",
          projectId: "YOUR_PROJECT_ID",
          storageBucket: "YOUR_STORAGE_BUCKET",
          messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
          appId: "YOUR_APP_ID",
          measurementId: "YOUR_MEASUREMENT_ID",
        ),
      );
    } else {
   
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }
    }
  }

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(ChatModelAdapter().typeId)) {
    Hive.registerAdapter(ChatModelAdapter());
  }
  await DbChatFunctions.getChatList();
}