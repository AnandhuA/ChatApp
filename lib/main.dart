import 'package:chatapp/functions/db_functions.dart';
import 'package:chatapp/persentation/authentication/login_screen.dart';
import 'package:chatapp/persentation/chat/bloc/chat_bloc.dart';
import 'package:chatapp/persentation/models/chat_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(ChatModelAdapter().typeId)) {
    Hive.registerAdapter(ChatModelAdapter());
  }
  await DbChatFunctions.getChatList();
  print(chatList);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
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
