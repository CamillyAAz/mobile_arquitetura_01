import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_user.dart';

class SessionController {
  static final SessionController instance = SessionController._();
  static const String _userKey = 'authenticated_user';

  SessionController._();

  AuthUser? _user;

  AuthUser? get user => _user;

  String? get token => _user?.accessToken;

  bool get isLoggedIn => _user != null;

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);

    if (userJson == null) return;

    try {
      _user = AuthUser.fromJson(jsonDecode(userJson) as Map<String, dynamic>);
    } catch (_) {
      await prefs.remove(_userKey);
      _user = null;
    }
  }

  Future<void> login(AuthUser user) async {
    _user = user;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  Future<void> logout() async {
    _user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
