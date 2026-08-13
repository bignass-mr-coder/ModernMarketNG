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
}