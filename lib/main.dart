import 'package:chatapp/functions/db_functions.dart';
import 'package:chatapp/persentation/authentication/bloc/authentication_bloc.dart';
import 'package:chatapp/persentation/chat/bloc/chat_bloc.dart';
import 'package:chatapp/models/chat_model.dart';
import 'package:chatapp/persentation/splash/splash.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp();

  if (!Hive.isAdapterRegistered(ChatModelAdapter().typeId)) {
    Hive.registerAdapter(ChatModelAdapter());
  }
  await DbChatFunctions.getChatList();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChatBloc(),
        ),
        BlocProvider(
          create: (context) => AuthenticationBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
          ),
        ),
        themeMode: ThemeMode.dark,
      ),
    );
  }
}
