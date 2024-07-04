import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      "senderId": this.senderId,
      "senderEmail": this.senderEmail,
      "receiverId": this.receiverId,
      "message": this.message,
      "timestamp": this.timestamp,
    };
  }

  factory Message.fromMap({required Map<String, dynamic> json}) {
    return Message(
      senderId: json["senderId"],
      senderEmail: json["senderEmail"],
      receiverId: json["receiverId"],
      message: json["message"],
      timestamp: json["timestamp"],
    );
  }
}
