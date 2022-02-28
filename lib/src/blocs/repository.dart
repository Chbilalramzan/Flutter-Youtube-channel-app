import 'auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Repository {
  final AuthProvider authProvider = AuthProvider();
  Future<String> login(String email, String password) =>
      authProvider.login(email: email, password: password);
}
