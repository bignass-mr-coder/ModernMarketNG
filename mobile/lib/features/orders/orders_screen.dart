import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile/features/orders/order_details_screen.dart';
import 'package:mobile/managers/order_manager.dart';
import 'package:mobile/models/order.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrderManager>().orders;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: orders.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 70,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No orders yet',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your placed orders will appear here.',
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final order = orders[index];

                return InkWell(
  borderRadius: BorderRadius.circular(12),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OrderDetailsScreen(order: order),
      ),
    );
  },
  child: _OrderCard(order: order),
);
              },
            ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({
    required this.order,
  });

  final Order order;

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();

    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '$day/$month/$year • $hour:$minute $period';
  }

  Color _statusColor(BuildContext context) {
    switch (order.status) {
      case 'Confirmed':
        return Colors.blue;
      case 'Shipped':
        return Colors.orange;
      case 'Delivered':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      case 'Pending':
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(context);

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ORDER ID + STATUS
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Text(
                    'Order',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    order.status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            Text(
              order.id,
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context)
                    .colorScheme
                    .primary,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            // DATE
            Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  _formatDate(order.createdAt),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // ITEMS
            Row(
              children: [
                const Icon(
                  Icons.inventory_2_outlined,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '${order.items.length} item(s)',
                ),
              ],
            ),

            const SizedBox(height: 10),

            // DELIVERY METHOD
            Row(
              children: [
                const Icon(
                  Icons.local_shipping_outlined,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(order.deliveryMethod),
              ],
            ),

            const SizedBox(height: 10),

            // PAYMENT METHOD
            Row(
              children: [
                const Icon(
                  Icons.payment_outlined,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(order.paymentMethod),
              ],
            ),

            const Divider(height: 24),

            // TOTAL
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '₦${order.total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}