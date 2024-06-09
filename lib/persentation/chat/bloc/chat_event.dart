part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class SendButtonClickEvent extends ChatEvent {
  final String message;

  SendButtonClickEvent({
    required this.message,
  });
}
