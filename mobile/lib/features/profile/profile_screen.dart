import 'package:flutter/material.dart';

import 'package:mobile/features/orders/orders_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const CircleAvatar(
            radius: 42,
            child: Icon(
              Icons.person,
              size: 45,
            ),
          ),

          const SizedBox(height: 16),

          const Center(
            child: Text(
              'My Account',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 30),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.receipt_long_outlined,
              ),
              title: const Text(
                'My Orders',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: const Text(
                'View your orders and order status',
              ),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const OrdersScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}