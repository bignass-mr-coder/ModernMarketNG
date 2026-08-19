import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mobile/features/auth/login_screen.dart';
import 'package:mobile/features/orders/orders_screen.dart';
import 'package:mobile/features/seller/seller_dashboard_screen.dart';
import 'package:mobile/managers/auth_manager.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthManager>(
      builder: (context, authManager, child) {
        final user = authManager.currentUser;
        final isLoggedIn = authManager.isLoggedIn;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              CircleAvatar(
                radius: 42,
                child: Icon(
                  isLoggedIn
                      ? Icons.person
                      : Icons.person_outline,
                  size: 45,
                ),
              ),

              const SizedBox(height: 16),

              Center(
                child: Text(
                  isLoggedIn
                      ? user?.fullName ?? 'User'
                      : 'My Account',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Center(
                child: Text(
                  isLoggedIn
                      ? user?.email ?? ''
                      : 'Sign in to manage your account',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                ),

              const SizedBox(height: 24),

              if (!isLoggedIn) ...[
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
              ],

              const SizedBox(height: 12),

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
                        builder: (_) =>
                            const SellerDashboardScreen(),
                      ),
                    );
                  },
                ),
              ),

              if (isLoggedIn) ...[
                const SizedBox(height: 24),

                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.logout,
                    ),
                    title: const Text(
                      'Log Out',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: const Text(
                      'Sign out of your Modern Market NG account',
                    ),
                    onTap: () async {
                      await authManager.logout();

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'You have been logged out.',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}