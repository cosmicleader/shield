import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String displayName;
  final String phoneNumber;
  final String dateOfBirth;
  final String gender;
  final String location;
  final String photoURL;

  UserModel({
    required this.uid,
    required this.displayName,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.location,
    required this.photoURL,
  });

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      uid: data['uid'] ?? '',
      displayName: data['displayName'] ?? 'No Name',
      phoneNumber: data['phoneNumber'] ?? '00000000000000',
      dateOfBirth: data['dateOfBirth'] ?? '',
      gender: data['gender'] ?? 'NILL',
      location: data['location'] ?? 'Not Set',
      photoURL: data['photoURL'] ?? 'NULL',
    );
  }
}
