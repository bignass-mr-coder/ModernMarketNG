import 'package:flutter/material.dart';

/// A premium delivery information card shown on the Product Details page.
///
/// Displays a rich header, estimated delivery date, delivery fee, pickup
/// option availability, return policy, and a trust section (verified
/// seller, secure payment, nationwide delivery) — similar to what you'd
/// see on Amazon/Jumia product pages.
///
/// This widget is purely presentational and accepts dummy/mock data via
/// its constructor so it can be reused across different product screens.
class ProductDeliveryCard extends StatelessWidget {
  const ProductDeliveryCard({
    super.key,
    this.deliveryLocation = 'Lagos, Nigeria',
    this.estimatedDeliveryDate = 'Wed, 13 Aug - Fri, 15 Aug',
    this.deliveryFee = '₦1,500',
    this.isFreeDelivery = false,
    this.isPickupAvailable = true,
    this.returnPolicyDays = 7,
    this.onChangeLocation,
  });

  /// The current delivery location (e.g. user's saved address / city).
  final String deliveryLocation;

  /// Estimated delivery date range as a display-ready string.
  final String estimatedDeliveryDate;

  /// Delivery fee as a display-ready string (ignored if [isFreeDelivery] is true).
  final String deliveryFee;

  /// Whether delivery is free for this product/order.
  final bool isFreeDelivery;

  /// Whether the product supports in-store / pickup station collection.
  final bool isPickupAvailable;

  /// Number of days allowed for returns.
  final int returnPolicyDays;

  /// Callback fired when the user taps "Change" next to the delivery location.
  final VoidCallback? onChangeLocation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outlineVariant, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            _buildLocationRow(context),
            const Divider(height: 28),
            _buildDeliveryItemContainer(
              context,
              icon: Icons.local_shipping_rounded,
              title: isFreeDelivery ? 'Free Delivery' : 'Standard Delivery',
              subtitle: 'Arrives $estimatedDeliveryDate',
              trailing: isFreeDelivery
                  ? Text(
                      'FREE',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Text(
                      deliveryFee,
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
            ),
            if (isPickupAvailable) ...[
              const SizedBox(height: 10),
              _buildDeliveryItemContainer(
                context,
                icon: Icons.storefront_rounded,
                title: 'Pickup Station Available',
                subtitle: 'Collect at a nearby pickup point to save cost',
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            const SizedBox(height: 10),
            _buildDeliveryItemContainer(
              context,
              icon: Icons.replay_circle_filled_rounded,
              title: 'Easy Returns',
              subtitle: 'Free returns within $returnPolicyDays days',
              trailing: null,
            ),
            const SizedBox(height: 20),
            _buildTrustSection(context),
          ],
        ),
      ),
    );
  }

  /// Premium header with icon, title, and a short trust-building subtitle.
  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.local_shipping_rounded,
            size: 22,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delivery & Returns',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Fast, secure and reliable delivery across Nigeria.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLocationRow(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          size: 18,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            'Deliver to: $deliveryLocation',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        TextButton(
          onPressed: onChangeLocation,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text('Change'),
        ),
      ],
    );
  }

  /// A rounded container wrapping a single delivery info row
  /// (icon + title + subtitle + optional trailing widget).
  Widget _buildDeliveryItemContainer(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget? trailing,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.6)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: colorScheme.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 8),
            trailing,
          ],
        ],
      ),
    );
  }

  /// Trust section shown at the bottom of the card, reinforcing buyer
  /// confidence — similar to premium marketplace product pages.
  Widget _buildTrustSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTrustRow(
            context,
            icon: Icons.verified_rounded,
            iconColor: Colors.blue.shade600,
            title: 'Verified Seller',
            subtitle: 'Product sold by a trusted Modern Market NG seller',
          ),
          const SizedBox(height: 14),
          _buildTrustRow(
            context,
            icon: Icons.lock_rounded,
            iconColor: Colors.green.shade700,
            title: 'Secure Payment',
            subtitle: 'Your payment is protected and encrypted',
          ),
          const SizedBox(height: 14),
          _buildTrustRow(
            context,
            icon: Icons.local_shipping_rounded,
            iconColor: theme.colorScheme.primary,
            title: 'Nationwide Delivery',
            subtitle: 'Delivery available across Nigeria',
          ),
        ],
      ),
    );
  }

  Widget _buildTrustRow(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: iconColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}