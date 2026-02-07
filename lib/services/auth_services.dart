import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  /// LOGIN
  Future<void> login({required String email, required String password}) async {
    await _client.auth.signInWithPassword(email: email, password: password);
  }

  /// SIGNUP WITH NAME
  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    await _client.auth.signUp(
      email: email,
      password: password,
      data: {
        'name': name, // 👈 stored in user metadata
      },
    );
  }

  /// CURRENT USER
  User? get currentUser => _client.auth.currentUser;

  /// GET USER NAME
  String? get currentUserName =>
      _client.auth.currentUser?.userMetadata?['name'];

  /// LOGOUT
  Future<void> logout() async {
    await _client.auth.signOut();
  }
}
