// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/chat/ui/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class UserTile extends StatelessWidget {
  final String fullName;
  final String email;
  final String userId;
  final String otherUserId;

  const UserTile({
    Key? key,
    required this.fullName,
    required this.email,
    required this.userId,
    required this.otherUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(PageTransition(
            child: ChatScreen(
              userId: userId,
              otherUserId: otherUserId,
              receiverName: fullName,
            ),
            type: PageTransitionType.fade));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 12.5),
        padding: EdgeInsets.all(25),
        child: Row(
          children: [
            Icon(Icons.person),
            SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fullName),
                Text(
                  email,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
