// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app/chat/cubit/fetch_messages_cubit.dart';
import 'package:chat_app/chat/cubit/send_message_cubit.dart';
import 'package:chat_app/chat/model/message.dart';
import 'package:chat_app/common/components/message_box.dart';
import 'package:chat_app/common/components/my_text_field.dart';
import 'package:chat_app/common/state/common_state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ChatWidget extends StatefulWidget {
  final String receiverId;
  final String receiverName;
  const ChatWidget({
    Key? key,
    required this.receiverId,
    required this.receiverName,
  }) : super(key: key);

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  ScrollController _scrollController = ScrollController();
  FocusNode _focusNode = FocusNode();
  TextEditingController? _controller;

  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.linear);
  }

  @override
  void initState() {
    _controller = TextEditingController();
    _focusNode.addListener(
      () {
        if (_focusNode.hasFocus) {
          Future.delayed(Duration(milliseconds: 900), scrollDown);
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(widget.receiverName),
        centerTitle: true,
      ),
      body: BlocListener<SendMessageCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonSuccessState) {
            scrollDown();
          }
          if (state is CommonErrorState) {
            Fluttertoast.showToast(
                msg: state.message ?? "unable to send message");
          }
        },
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<FetchMessagesCubit, CommonState>(
                listener: (context, state) {
                  if (state is CommonErrorState) {
                    Fluttertoast.showToast(
                        msg: state.message ?? "unable to send message");
                  }

                  if (state is CommonSuccessState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      scrollDown(); // Execute scrollDown() after the current frame
                    });
                  }
                  if (state is CommonLoadingState) {
                    context.loaderOverlay.show();
                  } else {
                    context.loaderOverlay.hide();
                  }
                },
                builder: (context, state) {
                  if (state is CommonSuccessState<List<Message>>) {
                    return ListView.builder(
                      controller: _scrollController,
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
      ),
    );
  }

  Widget _buildUserInput(BuildContext context) {
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
                focusNode: _focusNode,
              ),
            ),
            FittedBox(
              fit: BoxFit.fitHeight,
              child: InkWell(
                onTap: () {
                  if (_controller!.text.isNotEmpty) {
                    context.read<SendMessageCubit>().sendMessages(
                          message: _controller!.text,
                          receiverId: widget.receiverId,
                        );
                    _controller!.clear();
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
