
import 'package:hive_flutter/hive_flutter.dart';
part 'chat_model.g.dart';

@HiveType(typeId: 1)
class ChatModel {
  @HiveField(0)
  final String message;
  @HiveField(1)
  final String code;

  ChatModel({
    required this.message,
    required this.code,
  });
}
