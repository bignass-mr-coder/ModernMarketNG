class User {
  const User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.createdAt,
    this.role = 'buyer',
    this.sellerId,
  });

  final String id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final DateTime createdAt;

  final String role;
  final String? sellerId;

  bool get isBuyer => role == 'buyer';

  bool get isSeller => role == 'seller';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'createdAt': createdAt.toIso8601String(),
      'role': role,
      'sellerId': sellerId,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      createdAt: DateTime.parse(
        map['createdAt'] as String,
      ),
      role: map['role'] as String? ?? 'buyer',
      sellerId: map['sellerId'] as String?,
    );
  }

  User copyWith({
    String? fullName,
    String? email,
    String? phoneNumber,
    String? role,
    String? sellerId,
    bool clearSellerId = false,
  }) {
    return User(
      id: id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdAt: createdAt,
      role: role ?? this.role,
      sellerId: clearSellerId
          ? null
          : sellerId ?? this.sellerId,
    );
  }
}