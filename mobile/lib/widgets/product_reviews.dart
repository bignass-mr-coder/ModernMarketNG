 import 'package:flutter/material.dart';

/// A premium "Customer Reviews" section for the Product Details page.
///
/// Displays an overall rating summary, a five-star distribution breakdown,
/// a list of mock customer reviews (with verified purchase badges and a
/// locally-interactive "Helpful" button), and a "See all reviews" action.
///
/// This widget is purely presentational — it contains no backend, database,
/// API, or networking logic. All data is supplied via constructor
/// parameters (with realistic Nigerian-marketplace dummy defaults), making
/// it safe to reuse across any product screen.
class ProductReviews extends StatelessWidget {
  const ProductReviews({
    super.key,
    this.overallRating = 4.6,
    this.totalReviewCount = 328,
    this.ratingDistribution = const {
      5: 0.72,
      4: 0.16,
      3: 0.07,
      2: 0.03,
      1: 0.02,
    },
    this.reviews = const [
      ProductReview(
        reviewerName: 'Chiamaka O.',
        rating: 5,
        date: '2 weeks ago',
        isVerifiedPurchase: true,
        reviewText:
            'Very good quality, exactly as pictured. Delivery to Lekki was '
            'faster than I expected. Will order again from this seller.',
        helpfulCount: 24,
      ),
      ProductReview(
        reviewerName: 'Ibrahim S.',
        rating: 4,
        date: '1 month ago',
        isVerifiedPurchase: true,
        reviewText:
            'Good product overall. Packaging was neat and the item matches '
            'the description. Only issue is it took a few extra days to '
            'arrive in Kano.',
        helpfulCount: 15,
      ),
      ProductReview(
        reviewerName: 'Ngozi A.',
        rating: 5,
        date: '1 month ago',
        isVerifiedPurchase: true,
        reviewText:
            'I was skeptical about ordering online but this exceeded my '
            'expectations. Premium feel and the seller responded to all my '
            'questions promptly.',
        helpfulCount: 41,
      ),
      ProductReview(
        reviewerName: 'Emeka N.',
        rating: 3,
        date: '2 months ago',
        isVerifiedPurchase: false,
        reviewText:
            'Product is okay for the price. Nothing extraordinary but does '
            'the job. Would have liked more color options.',
        helpfulCount: 6,
      ),
    ],
    this.onSeeAllReviews,
  });

  /// The average rating out of 5 (e.g. 4.6).
  final double overallRating;

  /// Total number of reviews submitted for this product.
  final int totalReviewCount;

  /// Maps star value (1-5) to the fraction (0.0-1.0) of reviews with that
  /// rating. Used to render the horizontal distribution bars.
  final Map<int, double> ratingDistribution;

  /// The list of reviews to display beneath the summary.
  final List<ProductReview> reviews;

  /// Callback fired when the user taps "See all reviews".
  final VoidCallback? onSeeAllReviews;

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
            _buildRatingSummary(context),
            const SizedBox(height: 20),
            const Divider(height: 1),
            const SizedBox(height: 12),
            ...List.generate(reviews.length, (index) {
              final isLast = index == reviews.length - 1;
              return Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
                child: _ReviewCard(review: reviews[index]),
              );
            }),
            const SizedBox(height: 8),
            _buildSeeAllButton(context),
          ],
        ),
      ),
    );
  }

  /// Header row with an icon and the "Customer Reviews" title.
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
            Icons.reviews_rounded,
            size: 22,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Customer Reviews',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  /// Summary row combining the overall numeric rating with the five-star
  /// distribution bars. Wraps to a column layout on very narrow screens.
  Widget _buildRatingSummary(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 360;

        final scoreColumn = _buildScoreColumn(context);
        final distributionColumn = _buildDistributionColumn(context);

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              scoreColumn,
              const SizedBox(height: 16),
              distributionColumn,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            scoreColumn,
            const SizedBox(width: 24),
            Expanded(child: distributionColumn),
          ],
        );
      },
    );
  }

  Widget _buildScoreColumn(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          overallRating.toStringAsFixed(1),
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        _StarRow(rating: overallRating, size: 18),
        const SizedBox(height: 4),
        Text(
          '$totalReviewCount reviews',
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildDistributionColumn(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final star = 5 - index;
        final fraction = ratingDistribution[star] ?? 0.0;
        final isLast = star == 1;

        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : 6),
          child: _DistributionBarRow(star: star, fraction: fraction),
        );
      }),
    );
  }

  Widget _buildSeeAllButton(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onSeeAllReviews,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 13),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
        child: Text(
          'See all $totalReviewCount reviews',
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/// Immutable data model representing a single customer review.
///
/// This is a plain data holder with no backend or networking logic —
/// instances are constructed with mock data by the caller.
class ProductReview {
  const ProductReview({
    required this.reviewerName,
    required this.rating,
    required this.date,
    required this.reviewText,
    this.isVerifiedPurchase = false,
    this.helpfulCount = 0,
  });

  /// Display name of the reviewer.
  final String reviewerName;

  /// Star rating given, from 1 to 5.
  final int rating;

  /// Display-ready relative date string (e.g. "2 weeks ago").
  final String date;

  /// The written review content.
  final String reviewText;

  /// Whether this review is tagged as a verified purchase.
  final bool isVerifiedPurchase;

  /// Initial count of users who marked this review as helpful.
  final int helpfulCount;
}

/// A horizontal bar row representing what fraction of reviews gave a
/// specific star rating (e.g. "5 ★ ████████░░ 72%").
///
/// Kept private since it is only meant to be used within
/// [ProductReviews].
class _DistributionBarRow extends StatelessWidget {
  const _DistributionBarRow({
    required this.star,
    required this.fraction,
  });

  final int star;
  final double fraction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final clampedFraction = fraction.clamp(0.0, 1.0);

    return Row(
      children: [
        SizedBox(
          width: 18,
          child: Text(
            '$star',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Icon(Icons.star_rounded, size: 14, color: Colors.amber.shade600),
        const SizedBox(width: 8),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: clampedFraction,
              minHeight: 8,
              backgroundColor: colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.amber.shade600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 34,
          child: Text(
            '${(clampedFraction * 100).round()}%',
            textAlign: TextAlign.right,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}

/// Renders a row of filled/half/empty star icons for a given rating.
///
/// Kept private since it is only meant to be used within
/// [ProductReviews].
class _StarRow extends StatelessWidget {
  const _StarRow({required this.rating, this.size = 16});

  final double rating;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starValue = index + 1;
        IconData icon;
        if (rating >= starValue) {
          icon = Icons.star_rounded;
        } else if (rating >= starValue - 0.5) {
          icon = Icons.star_half_rounded;
        } else {
          icon = Icons.star_border_rounded;
        }
        return Icon(icon, size: size, color: Colors.amber.shade600);
      }),
    );
  }
}

/// A single review card showing reviewer info, star rating, verified badge,
/// review text, and a locally-interactive "Helpful" button.
///
/// This is a [StatefulWidget] purely to track local UI state (whether the
/// current user has marked the review as helpful and the resulting count).
/// No state is persisted or sent anywhere.
///
/// Kept private since it is only meant to be used within [ProductReviews].
class _ReviewCard extends StatefulWidget {
  const _ReviewCard({required this.review});

  final ProductReview review;

  @override
  State<_ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<_ReviewCard> {
  late int _helpfulCount = widget.review.helpfulCount;
  bool _markedHelpful = false;

  void _toggleHelpful() {
    setState(() {
      if (_markedHelpful) {
        _helpfulCount -= 1;
      } else {
        _helpfulCount += 1;
      }
      _markedHelpful = !_markedHelpful;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final review = widget.review;

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
          _buildReviewerRow(context),
          const SizedBox(height: 10),
          Text(
            review.reviewText,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          _buildHelpfulButton(context),
        ],
      ),
    );
  }

  Widget _buildReviewerRow(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final review = widget.review;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: colorScheme.primaryContainer,
          child: Text(
            review.reviewerName.isNotEmpty
                ? review.reviewerName[0].toUpperCase()
                : '?',
            style: theme.textTheme.titleSmall?.copyWith(
              color: colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      review.reviewerName,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (review.isVerifiedPurchase) ...[
                    const SizedBox(width: 6),
                    _buildVerifiedBadge(context),
                  ],
                ],
              ),
              const SizedBox(height: 4),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                children: [
                  _StarRow(rating: review.rating.toDouble(), size: 14),
                  Text(
                    review.date,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVerifiedBadge(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.green.shade600.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified_rounded,
            size: 12,
            color: Colors.green.shade700,
          ),
          const SizedBox(width: 3),
          Text(
            'Verified Purchase',
            style: theme.textTheme.labelSmall?.copyWith(
              color: Colors.green.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpfulButton(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: _toggleHelpful,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _markedHelpful
                  ? Icons.thumb_up_rounded
                  : Icons.thumb_up_outlined,
              size: 16,
              color: _markedHelpful
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 6),
            Text(
              'Helpful ($_helpfulCount)',
              style: theme.textTheme.bodySmall?.copyWith(
                color: _markedHelpful
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}