import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mobile/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager extends ChangeNotifier {
  static const String _userKey = 'current_user';

  User? _currentUser;

  User? get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;

  Future<void> loadUser() async {
    final preferences = await SharedPreferences.getInstance();

    final savedUser = preferences.getString(_userKey);

    if (savedUser == null || savedUser.isEmpty) {
      return;
    }

    _currentUser = User.fromMap(
      jsonDecode(savedUser) as Map<String, dynamic>,
    );

    notifyListeners();
  }

  Future<void> registerUser(User user) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString(
      _userKey,
      jsonEncode(user.toMap()),
    );

    _currentUser = user;

    notifyListeners();
  }

  Future<void> loginUser(User user) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString(
      _userKey,
      jsonEncode(user.toMap()),
    );

    _currentUser = user;

    notifyListeners();
  }

  Future<void> logout() async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.remove(_userKey);

    _currentUser = null;

    notifyListeners();
  }
}