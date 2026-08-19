class Seller {
  const Seller({
    required this.id,
    required this.businessName,
    required this.ownerName,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.category,
    required this.description,
    this.logoUrl,
    this.isVerified = false,
    required this.createdAt,
  });

  final String id;
  final String businessName;
  final String ownerName;
  final String phoneNumber;
  final String email;
  final String address;
  final String category;
  final String description;
  final String? logoUrl;
  final bool isVerified;
  final DateTime createdAt;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'businessName': businessName,
      'ownerName': ownerName,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
      'category': category,
      'description': description,
      'logoUrl': logoUrl,
      'isVerified': isVerified,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Seller.fromMap(Map<String, dynamic> map) {
    return Seller(
      id: map['id'] as String,
      businessName: map['businessName'] as String,
      ownerName: map['ownerName'] as String,
      phoneNumber: map['phoneNumber'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      category: map['category'] as String,
      description: map['description'] as String,
      logoUrl: map['logoUrl'] as String?,
      isVerified: map['isVerified'] as bool? ?? false,
      createdAt: DateTime.parse(
        map['createdAt'] as String,
      ),
    );
  }
}