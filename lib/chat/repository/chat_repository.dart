import 'package:chat_app/chat/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRepository {
  //firestore instance
  final _firestore = FirebaseFirestore.instance;

  //send message
  Future<Either<String, void>> sendMessage(
      {required String receiverId, required String message}) async {
    try {
      //get current user
      final _currentUser = FirebaseAuth.instance.currentUser;

      //get necessary  details
      final senderId = _currentUser!.uid;
      final senderEmail = _currentUser.email;
      final Timestamp timestamp = Timestamp.now();

      //create a  message
      final newMessage = Message(
        senderId: senderId,
        receiverId: receiverId,
        senderEmail: senderEmail!,
        message: message,
        timestamp: timestamp,
      );

      //create unique chatRoomId
      List<String> temp = [senderId, receiverId];
      temp.sort();
      String chatRoomId = temp.join("_");

      //store message in firestore
      await _firestore
          .collection("chat_rooms")
          .doc(chatRoomId)
          .collection("messages")
          .add(
            newMessage.toMap(),
          );
      return Right(null);
    } on FirebaseException catch (e) {
      return Left(e.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  //receive message
  Either<String, Stream<List<Message>>> fetchMessages(
      {required userId, required otherUserId}) {
    //create unique chatRoomId
    List<String> temp = [userId, otherUserId];
    temp.sort();
    String chatRoomId = temp.join("_");
    try {
      return Right(_firestore
          .collection("chat_rooms")
          .doc(chatRoomId)
          .collection("messages")
          .orderBy(
            "timestamp",
            descending: false,
          )
          .snapshots()
          .map(
        (snapshot) {
          return snapshot.docs.map((doc) {
            return Message.fromMap(json: doc.data());
          }).toList();
        },
      ));
    } on FirebaseException catch (e) {
      return Left(e.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }
}
