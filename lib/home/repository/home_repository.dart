import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class HomeRepository {
  Either<String, Stream<List<Map<String, dynamic>>>> fetchUsersList() {
    try {
      return Right(
        FirebaseFirestore.instance.collection("users").snapshots().map(
          (snapshot) {
            return snapshot.docs.map(
              (docSnapshot) {
                return docSnapshot.data();
              },
            ).toList();
          },
        ),
      );
    } on FirebaseException catch (e) {
      return Left(e.toString());
    } catch (e) {
      return (Left(e.toString()));
    }
  }
}
