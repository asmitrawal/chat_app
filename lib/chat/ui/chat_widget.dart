// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app/chat/cubit/fetch_messages_cubit.dart';
import 'package:chat_app/chat/cubit/send_message_cubit.dart';
import 'package:chat_app/chat/model/message.dart';
import 'package:chat_app/common/components/message_box.dart';
import 'package:chat_app/common/components/my_text_field.dart';
import 'package:chat_app/common/state/common_state.dart';

class ChatWidget extends StatelessWidget {
  final String receiverId;
  final String receiverName;
  const ChatWidget({
    Key? key,
    required this.receiverId,
    required this.receiverName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverName),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<FetchMessagesCubit, CommonState>(
              builder: (context, state) {
                if (state is CommonSuccessState<List<Message>>) {
                  return ListView.builder(
                    
                    itemBuilder: (context, index) {
                      return MessageBox(
                        message: state.item[index],
                      );
                    },
                    itemCount: state.item.length,
                  );
                } else {
                  return Center();
                }
              },
            ),
          ),
          _buildUserInput(context),
        ],
      ),
    );
  }

  Widget _buildUserInput(BuildContext context) {
    TextEditingController? _controller = TextEditingController();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: MyTextField(
                controller: _controller,
                hintText: "Type a message",
                obscureText: false,
              ),
            ),
            FittedBox(
              fit: BoxFit.fitHeight,
              child: InkWell(
                onTap: () {
                  if (_controller.text.isNotEmpty) {
                    context.read<SendMessageCubit>().sendMessages(
                          message: _controller.text,
                          receiverId: receiverId,
                        );
                    _controller.clear();
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: Icon(
                    Icons.send_rounded,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(width: 25),
          ],
        ),
      ),
    );
  }
}
