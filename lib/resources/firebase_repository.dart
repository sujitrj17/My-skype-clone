import 'package:firebase_auth/firebase_auth.dart';
import 'package:skype_clone/models/message.dart';
import 'package:skype_clone/models/user.dart';
import 'package:skype_clone/resources/firebase_methods.dart';

class FirebaseRepository {
  FirebaseMethods _firebaseMethods = FirebaseMethods();

  Future<FirebaseUser> getCurrentUser() => _firebaseMethods.getCurrentUser();

  Future<FirebaseUser> signIn() => _firebaseMethods.signIn();

  Future<bool> authenticateUser(FirebaseUser user) =>
      _firebaseMethods.authenticateUser(user);

  Future<void> addDataToDb(FirebaseUser user) => _firebaseMethods.addDataToDb(user);

  Future<List<User>> fetchAllUsers(FirebaseUser user) =>
      _firebaseMethods.fetchAllUsers(user);

  Future<List<User>> fetchAllUserWithCurrentUSer() =>  _firebaseMethods.getDummyUsers();

  Future<void> signOutofApp()  => _firebaseMethods.signOut();

  Future<void> addMessageToDb(Message message, User sender, User receiver) => _firebaseMethods.addMessageToDb(message,sender,receiver);
}