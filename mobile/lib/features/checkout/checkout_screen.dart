import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mobile/models/order.dart';
import 'package:mobile/features/checkout/order_confirmation_screen.dart';
import 'package:mobile/managers/cart_manager.dart';
import 'package:mobile/managers/order_manager.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  String _selectedDeliveryMethod = 'Standard Delivery';
  String _selectedPaymentMethod = 'Cash on Delivery';

  double get _deliveryFee {
    if (_selectedDeliveryMethod == 'Express Delivery') {
      return 3000;
    }

    return 1500;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _continueCheckout() {
    if (_formKey.currentState!.validate()) {
      _showOrderReview();
    }
  }

  void _showOrderReview() {
    final cartManager = context.read<CartManager>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        final total = cartManager.subtotal + _deliveryFee;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Order Review',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Your Items',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  ...cartManager.items.map(
                    (item) => Card(
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item.image,
                            width: 55,
                            height: 55,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) {
                              return Container(
                                width: 55,
                                height: 55,
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
                          maxLines: 1,
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

                  const SizedBox(height: 20),

                  const Text(
                    'Delivery',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(_selectedDeliveryMethod),
                    subtitle: Text(
                      _addressController.text,
                    ),
                    trailing: Text(
                      '₦${_deliveryFee.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const Divider(),

                  const SizedBox(height: 10),

                  _SummaryRow(
                    title: 'Subtotal',
                    value:
                        '₦${cartManager.subtotal.toStringAsFixed(2)}',
                  ),

                  const SizedBox(height: 8),

                  _SummaryRow(
                    title: 'Delivery Fee',
                    value:
                        '₦${_deliveryFee.toStringAsFixed(2)}',
                  ),

                  const SizedBox(height: 8),

                  _SummaryRow(
                    title: 'Payment',
                    value: _selectedPaymentMethod,
                  ),

                  const Divider(height: 28),

                  _SummaryRow(
                    title: 'Total',
                    value: '₦${total.toStringAsFixed(2)}',
                    isTotal: true,
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: FilledButton(
                      onPressed: () {
                        final orderId =
                            'MMNG-${DateTime.now().millisecondsSinceEpoch}';

                        final order = Order(
                          id: orderId,
                          customerName:
                              _nameController.text.trim(),
                          phoneNumber:
                              _phoneController.text.trim(),
                          address:
                              _addressController.text.trim(),
                          deliveryMethod:
                              _selectedDeliveryMethod,
                          paymentMethod:
                              _selectedPaymentMethod,
                          items: List.from(cartManager.items),
                          subtotal: cartManager.subtotal,
                          deliveryFee: _deliveryFee,
                          total: total,
                          createdAt: DateTime.now(),
                        );

                        // Save the order in OrderManager.
                        final orderManager =
                            context.read<OrderManager>();

                        orderManager.addOrder(order);

                        Navigator.pop(context);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                OrderConfirmationScreen(
                              orderId: order.id,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Place Order',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Delivery Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Please enter your full name';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Please enter your phone number';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Delivery Address',
                  hintText:
                      'Enter your full delivery address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Please enter your delivery address';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 28),

              const Text(
                'Delivery Method',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Card(
                child: RadioListTile<String>(
                  value: 'Standard Delivery',
                  groupValue: _selectedDeliveryMethod,
                  onChanged: (value) {
                    if (value == null) return;

                    setState(() {
                      _selectedDeliveryMethod = value;
                    });
                  },
                  title: const Text('Standard Delivery'),
                  subtitle: const Text('₦1,500'),
                ),
              ),

              Card(
                child: RadioListTile<String>(
                  value: 'Express Delivery',
                  groupValue: _selectedDeliveryMethod,
                  onChanged: (value) {
                    if (value == null) return;

                    setState(() {
                      _selectedDeliveryMethod = value;
                    });
                  },
                  title: const Text('Express Delivery'),
                  subtitle: const Text('₦3,000'),
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                'Payment Method',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Card(
                child: RadioListTile<String>(
                  value: 'Cash on Delivery',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    if (value == null) return;

                    setState(() {
                      _selectedPaymentMethod = value;
                    });
                  },
                  secondary: const Icon(Icons.money),
                  title: const Text('Cash on Delivery'),
                  subtitle: const Text(
                    'Pay when your order is delivered',
                  ),
                ),
              ),

              Card(
                child: RadioListTile<String>(
                  value: 'Online Payment',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    if (value == null) return;

                    setState(() {
                      _selectedPaymentMethod = value;
                    });
                  },
                  secondary: const Icon(Icons.credit_card),
                  title: const Text('Online Payment'),
                  subtitle: const Text(
                    'Pay securely online',
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton(
                  onPressed: _continueCheckout,
                  child: const Text(
                    'Review Order',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
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
            fontSize: isTotal ? 19 : 16,
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