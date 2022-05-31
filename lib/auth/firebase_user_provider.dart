import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class CRMChamadosFirebaseUser {
  CRMChamadosFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

CRMChamadosFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<CRMChamadosFirebaseUser> cRMChamadosFirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<CRMChamadosFirebaseUser>(
        (user) => currentUser = CRMChamadosFirebaseUser(user));
