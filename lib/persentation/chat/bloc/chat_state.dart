part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoadingState extends ChatState {}

final class ChatSuccessState extends ChatState {}

final class ChatErrorState extends ChatState {
  final String error;

  ChatErrorState({required this.error});
}
