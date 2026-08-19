import 'package:flutter/material.dart';

import 'package:mobile/features/auth/login_screen.dart';
import 'package:mobile/features/orders/orders_screen.dart';
import 'package:mobile/features/seller/seller_dashboard_screen.dart';

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

          const SizedBox(height: 8),

          const Center(
            child: Text(
              'Sign in to manage your account',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),

          const SizedBox(height: 24),

          // SIGN IN
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.login_outlined,
              ),
              title: const Text(
                'Sign In',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: const Text(
                'Sign in or create your Modern Market NG account',
              ),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // MY ORDERS
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

          const SizedBox(height: 12),

          // SELLER CENTER
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.storefront_outlined,
              ),
              title: const Text(
                'Seller Center',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: const Text(
                'Manage your products and orders',
              ),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SellerDashboardScreen(),
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