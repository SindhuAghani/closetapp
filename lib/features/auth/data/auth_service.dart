import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final _client = Supabase.instance.client;

  // naya account
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    final res = await _client.auth.signUp(email: email, password: password);
    final userId = res.user?.id;
    if (userId != null) {
      // trigger ne profile bana di hai, bas naam update karo
      await _client.from('profiles').update({'name': name}).eq('id', userId);
    }
  }

  // login
  Future<void> signIn({required String email, required String password}) async {
    await _client.auth.signInWithPassword(email: email, password: password);
  }

  // logout
  Future<void> signOut() async {
    await _client.auth.signOut();
  }


  bool get isLoggedIn => _client.auth.currentSession != null;


  Future<Map<String, dynamic>?> getProfile() async {
    final id = _client.auth.currentUser?.id;
    if (id == null) return null;
    return await _client.from('profiles').select().eq('id', id).single();
  }
}
