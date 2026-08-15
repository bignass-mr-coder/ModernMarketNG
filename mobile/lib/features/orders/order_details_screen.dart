import 'package:flutter/material.dart';
import 'package:mobile/models/order.dart';
import 'package:provider/provider.dart';

import 'package:mobile/managers/order_manager.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({
    super.key,
    required this.order,
    this.isSeller = false,
  });

  final Order order;
  final bool isSeller;

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();

    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '$day/$month/$year • $hour:$minute $period';
  }

  Color _statusColor(
    BuildContext context,
    Order currentOrder,
  ) {
    switch (currentOrder.status) {
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
    final currentOrder =
        context.watch<OrderManager>().getOrderById(order.id) ?? order;

    final statusColor = _statusColor(
      context,
      currentOrder,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ORDER HEADER
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Text(
                    'Order',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    currentOrder.status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text(
              currentOrder.id,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              _formatDate(currentOrder.createdAt),
              style: TextStyle(
                color: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 28),

            // ORDER STATUS
            const Text(
              'Order Status',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            _OrderStatusTimeline(
              order: currentOrder,
            ),

            // SELLER CONTROLS
            if (isSeller) ...[
              const SizedBox(height: 24),

              const Text(
                'Manage Order',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              if (currentOrder.status == 'Pending')
                _SellerStatusButton(
                  orderId: currentOrder.id,
                  title: 'Confirm Order',
                  icon: Icons.check_circle_outline,
                  status: 'Confirmed',
                ),

              if (currentOrder.status == 'Confirmed')
                _SellerStatusButton(
                  orderId: currentOrder.id,
                  title: 'Mark as Shipped',
                  icon: Icons.local_shipping_outlined,
                  status: 'Shipped',
                ),

              if (currentOrder.status == 'Shipped')
                _SellerStatusButton(
                  orderId: currentOrder.id,
                  title: 'Mark as Delivered',
                  icon: Icons.done_all,
                  status: 'Delivered',
                ),

              if (currentOrder.status != 'Delivered' &&
                  currentOrder.status != 'Cancelled') ...[
                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      context
                          .read<OrderManager>()
                          .updateOrderStatus(
                            currentOrder.id,
                            'Cancelled',
                          );
                    },
                    icon: const Icon(
                      Icons.cancel_outlined,
                    ),
                    label: const Text(
                      'Cancel Order',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ],

            // BUYER CANCEL BUTTON
            if (!isSeller &&
                currentOrder.status == 'Pending') ...[
              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    context
                        .read<OrderManager>()
                        .updateOrderStatus(
                          currentOrder.id,
                          'Cancelled',
                        );
                  },
                  child: const Text(
                    'Cancel Order',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 28),

            // CUSTOMER INFORMATION
            const Text(
              'Customer Information',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _InfoRow(
                      icon: Icons.person_outline,
                      title: 'Full Name',
                      value: currentOrder.customerName,
                    ),
                    const SizedBox(height: 14),
                    _InfoRow(
                      icon: Icons.phone_outlined,
                      title: 'Phone Number',
                      value: currentOrder.phoneNumber,
                    ),
                    const SizedBox(height: 14),
                    _InfoRow(
                      icon: Icons.location_on_outlined,
                      title: 'Delivery Address',
                      value: currentOrder.address,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // ORDER ITEMS
            const Text(
              'Order Items',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            ...currentOrder.items.map(
              (item) => Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item.image,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) {
                        return Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey.shade200,
                          child: const Icon(
                            Icons.image_not_supported_outlined,
                          ),
                        );
                      },
                    ),
                  ),
                  title: Text(
                    item.productName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    'Quantity: ${item.quantity}',
                  ),
                  trailing: Text(
                    item.price,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            // DELIVERY & PAYMENT
            const Text(
              'Delivery & Payment',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _InfoRow(
                      icon: Icons.local_shipping_outlined,
                      title: 'Delivery Method',
                      value: currentOrder.deliveryMethod,
                    ),
                    const SizedBox(height: 14),
                    _InfoRow(
                      icon: Icons.payment_outlined,
                      title: 'Payment Method',
                      value: currentOrder.paymentMethod,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // PAYMENT SUMMARY
            const Text(
              'Payment Summary',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _SummaryRow(
                      title: 'Subtotal',
                      value:
                          '₦${currentOrder.subtotal.toStringAsFixed(2)}',
                    ),
                    const SizedBox(height: 12),
                    _SummaryRow(
                      title: 'Delivery Fee',
                      value:
                          '₦${currentOrder.deliveryFee.toStringAsFixed(2)}',
                    ),
                    const Divider(height: 28),
                    _SummaryRow(
                      title: 'Total',
                      value:
                          '₦${currentOrder.total.toStringAsFixed(2)}',
                      isTotal: true,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _SellerStatusButton extends StatelessWidget {
  const _SellerStatusButton({
    required this.orderId,
    required this.title,
    required this.icon,
    required this.status,
  });

  final String orderId;
  final String title;
  final IconData icon;
  final String status;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: FilledButton.icon(
        onPressed: () {
          context.read<OrderManager>().updateOrderStatus(
                orderId,
                status,
              );
        },
        icon: Icon(icon),
        label: Text(title),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.title,
    required this.value,
    this.isTotal = false,
  });

  final String title;
  final String value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal
                ? FontWeight.bold
                : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _OrderStatusTimeline extends StatelessWidget {
  const _OrderStatusTimeline({
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    final statuses = [
      'Pending',
      'Confirmed',
      'Shipped',
      'Delivered',
    ];

    final currentIndex = statuses.indexOf(order.status);

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            for (int i = 0;
                i < statuses.length;
                i++)
              _StatusStep(
                title: statuses[i],
                isCompleted:
                    currentIndex >= 0 &&
                    i <= currentIndex,
                isCurrent:
                    currentIndex == i,
                isLast:
                    i == statuses.length - 1,
              ),

            if (order.status == 'Cancelled')
              const _StatusStep(
                title: 'Cancelled',
                isCompleted: true,
                isCurrent: true,
                isLast: true,
              ),
          ],
        ),
      ),
    );
  }
}

class _StatusStep extends StatelessWidget {
  const _StatusStep({
    required this.title,
    required this.isCompleted,
    required this.isCurrent,
    required this.isLast,
  });

  final String title;
  final bool isCompleted;
  final bool isCurrent;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final color = isCompleted
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.outline;

    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              isCompleted
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: color,
              size: 24,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 36,
                color: color.withValues(alpha: 0.35),
              ),
          ],
        ),
        const SizedBox(width: 12),
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight:
                  isCurrent
                      ? FontWeight.bold
                      : FontWeight.w500,
              color: isCompleted
                  ? Theme.of(context)
                      .colorScheme
                      .onSurface
                  : Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}