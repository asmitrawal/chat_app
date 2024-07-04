// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app/chat/model/message.dart';

class MessageBox extends StatelessWidget {
  final Message message;
  const MessageBox({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AlignmentGeometry? alignment =
        (context.read<AuthRepository>().currentUser!.uid == message.senderId)
            ? Alignment.centerRight
            : Alignment.centerLeft;

    BorderRadiusGeometry? borderRadius =
        (context.read<AuthRepository>().currentUser!.uid == message.senderId)
            ? BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )
            : BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              );

    Color? messageBoxColor =
        (context.read<AuthRepository>().currentUser!.uid == message.senderId)
            ? Theme.of(context).colorScheme.tertiary
            : Theme.of(context).colorScheme.secondary;

    Color? textColor =
        (context.read<AuthRepository>().currentUser!.uid == message.senderId)
            ? Theme.of(context).colorScheme.tertiaryFixed
            : Theme.of(context).colorScheme.onSecondary;

    return Container(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.55,
        ),
        padding: EdgeInsets.all(12.5),
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 2),
        decoration: BoxDecoration(
          color: messageBoxColor,
          borderRadius: borderRadius,
        ),
        child: Text(
          message.message,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
