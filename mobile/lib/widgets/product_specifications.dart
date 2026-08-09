import 'package:flutter/material.dart';

/// A premium "Specifications" section for the Product Details page.
///
/// Displays a set of key-value specification rows (brand, material, color,
/// size, style, origin, condition, warranty) followed by a "What's Included"
/// summary, styled similarly to Amazon/Jumia/Temu product pages.
///
/// This widget is purely presentational — it accepts dummy/mock data via
/// its constructor and contains no backend or networking logic, making it
/// safe to reuse across any product screen.
class ProductSpecifications extends StatelessWidget {
  const ProductSpecifications({
    super.key,
    this.brand = 'Modern Market NG',
    this.material = 'Premium Cotton Blend',
    this.color = 'Midnight Black',
    this.size = 'Medium (M)',
    this.style = 'Casual Fit',
    this.origin = 'Made in Nigeria',
    this.warranty = '6 Months Warranty',
    this.condition = 'Brand New',
  });

  /// The product's brand name.
  final String brand;

  /// The primary material the product is made from.
  final String material;

  /// The product's color.
  final String color;

  /// The product's size.
  final String size;

  /// The product's style category.
  final String style;

  /// The product's country/region of origin.
  final String origin;

  /// The warranty coverage offered with the product.
  final String warranty;

  /// The product's condition (e.g. Brand New, Refurbished).
  final String condition;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: colorScheme.outlineVariant, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 18),
            Container(
  padding: const EdgeInsets.all(14),
  decoration: BoxDecoration(
    color: colorScheme.surfaceContainerLow,
    borderRadius: BorderRadius.circular(14),
    border: Border.all(
      color: colorScheme.outlineVariant.withValues(alpha: 0.6),
    ),
  ),
  child: _buildSpecificationsList(context),
),
            const SizedBox(height: 20),
            _buildWhatsIncludedSection(context),
          ],
        ),
      ),
    );
  }

  /// Header row with an icon and the "Specifications" title.
  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.fact_check_rounded,
            size: 22,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Specifications',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  /// Builds the full list of specification rows, each separated by a
  /// divider except the very last one.
  Widget _buildSpecificationsList(BuildContext context) {
    final specs = <_SpecEntry>[
      _SpecEntry('Brand', brand),
      _SpecEntry('Material', material),
      _SpecEntry('Color', color),
      _SpecEntry('Size', size),
      _SpecEntry('Style', style),
      _SpecEntry('Origin', origin),
      _SpecEntry('Condition', condition),
      _SpecEntry('Warranty', warranty),
    ];

    return Column(
      children: List.generate(specs.length, (index) {
        final entry = specs[index];
        final isLast = index == specs.length - 1;

        return Column(
          children: [
            _SpecificationRow(label: entry.label, value: entry.value),
            if (!isLast) const Divider(height: 22),
          ],
        );
      }),
    );
  }

  /// Rounded container listing what comes in the box with the product.
  Widget _buildWhatsIncludedSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    const includedItems = [
      'Product',
      'Premium Packaging',
      'Warranty Card',
      'User Guide',
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.6),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What's Included",
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 18,
            runSpacing: 10,
            children: includedItems
                .map((item) => _IncludedItem(label: item))
                .toList(growable: false),
          ),
        ],
      ),
    );
  }
}

/// Internal data holder pairing a specification label with its value.
class _SpecEntry {
  const _SpecEntry(this.label, this.value);

  final String label;
  final String value;
}

/// A single specification row displaying a label on the left and its
/// corresponding value right-aligned on the right.
///
/// Kept private since it is only meant to be used within
/// [ProductSpecifications].
class _SpecificationRow extends StatelessWidget {
  const _SpecificationRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 3,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

/// A single "included item" chip-like row used inside the
/// "What's Included" section, showing a green check icon and a label.
///
/// Kept private since it is only meant to be used within
/// [ProductSpecifications].
class _IncludedItem extends StatelessWidget {
  const _IncludedItem({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.check_circle_rounded,
          size: 18,
          color: Colors.green.shade600,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}