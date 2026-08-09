import 'package:flutter/material.dart';

class SellerCard extends StatelessWidget {
  const SellerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: const CircleAvatar(
          radius: 28,
          backgroundColor: Colors.blue,
          child: Icon(
            Icons.store,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Bignass Morocco Style",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text("⭐⭐⭐⭐⭐ Trusted Seller"),
            SizedBox(height: 4),
            Text("📍 Zamfara State, Nigeria"),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: null,
          child: Text("Visit"),
        ),
      ),
    );
  }
}