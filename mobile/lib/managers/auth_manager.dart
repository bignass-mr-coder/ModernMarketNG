import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:mobile/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager extends ChangeNotifier {
  static const String _userKey = 'current_user';

  final firebase_auth.FirebaseAuth _firebaseAuth =
      firebase_auth.FirebaseAuth.instance;

  User? _currentUser;

  User? get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;

  bool get isSeller => _currentUser?.isSeller ?? false;

  bool get isBuyer => _currentUser?.isBuyer ?? false;

  Future<void> loadUser() async {
    final firebaseUser = _firebaseAuth.currentUser;

    if (firebaseUser == null) {
      _currentUser = null;
      notifyListeners();
      return;
    }

    final preferences = await SharedPreferences.getInstance();

    final savedUser = preferences.getString(_userKey);

    if (savedUser == null || savedUser.isEmpty) {
      return;
    }

    _currentUser = User.fromMap(
      _decodeUser(savedUser),
    );

    notifyListeners();
  }

  Future<void> registerUser(
    User user, {
    required String password,
  }) async {
    final credential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: user.email,
      password: password,
    );

    final firebaseUser = credential.user;

    if (firebaseUser == null) {
      throw Exception('Account creation failed.');
    }

    await firebaseUser.updateDisplayName(user.fullName);

    final firebaseUserModel = User(
      id: firebaseUser.uid,
      fullName: user.fullName,
      email: firebaseUser.email ?? user.email,
      phoneNumber: user.phoneNumber,
      createdAt: user.createdAt,
      role: user.role,
      sellerId: user.sellerId,
    );

    await _saveUser(firebaseUserModel);
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    final credential =
        await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final firebaseUser = credential.user;

    if (firebaseUser == null) {
      throw Exception('Login failed.');
    }

    final preferences = await SharedPreferences.getInstance();

    final savedUser = preferences.getString(_userKey);

    if (savedUser != null && savedUser.isNotEmpty) {
      _currentUser = User.fromMap(
        _decodeUser(savedUser),
      );
    } else {
      _currentUser = User(
        id: firebaseUser.uid,
        fullName: firebaseUser.displayName ?? '',
        email: firebaseUser.email ?? email,
        phoneNumber: '',
        createdAt: DateTime.now(),
      );
    }

    notifyListeners();
  }

  Future<void> updateUser(User updatedUser) async {
    await _saveUser(updatedUser);
  }

  Future<void> makeSeller(String sellerId) async {
    if (_currentUser == null) {
      return;
    }

    final updatedUser = _currentUser!.copyWith(
      role: 'seller',
      sellerId: sellerId,
    );

    await _saveUser(updatedUser);
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();

    final preferences = await SharedPreferences.getInstance();

    await preferences.remove(_userKey);

    _currentUser = null;

    notifyListeners();
  }

  Future<void> _saveUser(User user) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString(
      _userKey,
      _encodeUser(user),
    );

    _currentUser = user;

    notifyListeners();
  }

  Map<String, dynamic> _decodeUser(String value) {
    return Map<String, dynamic>.from(
      _jsonDecode(value) as Map,
    );
  }

  String _encodeUser(User user) {
    return _jsonEncode(user.toMap());
  }

  dynamic _jsonDecode(String value) {
    return jsonDecode(value);
  }

  String _jsonEncode(Object? value) {
    return jsonEncode(value);
  }
}