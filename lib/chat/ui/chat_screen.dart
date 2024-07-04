import 'package:chat_app/chat/cubit/fetch_messages_cubit.dart';
import 'package:chat_app/chat/cubit/send_message_cubit.dart';
import 'package:chat_app/chat/repository/chat_repository.dart';
import 'package:chat_app/chat/ui/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  final String userId;
  final String otherUserId;
  final String receiverName;
  const ChatScreen(
      {required this.userId,
      required this.otherUserId,
      required this.receiverName,
      super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => FetchMessagesCubit(
                  repository: context.read<ChatRepository>(),
                )..fetchMessages(userId: userId, otherUserId: otherUserId)),
        BlocProvider(
          create: (context) =>
              SendMessageCubit(repository: context.read<ChatRepository>()),
        ),
      ],
      child: ChatWidget(
        receiverId: userId,
        receiverName: receiverName,
      ),
    );
  }
}
