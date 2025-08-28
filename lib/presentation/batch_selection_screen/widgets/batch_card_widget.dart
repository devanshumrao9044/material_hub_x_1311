import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme/app_theme.dart';
import '../batch_selection_screen.dart';
import './batch_details_modal_widget.dart';

class BatchCardWidget extends StatelessWidget {
  final BatchInfo batch;
  final bool isComparisonMode;
  final bool isInComparison;
  final VoidCallback onTap;
  final VoidCallback onStartFreeTrial;
  final VoidCallback onRemoveFromComparison;

  const BatchCardWidget({
    super.key,
    required this.batch,
    this.isComparisonMode = false,
    this.isInComparison = false,
    required this.onTap,
    required this.onStartFreeTrial,
    required this.onRemoveFromComparison,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isComparisonMode ? null : onTap,
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: batch.isSelected && !isComparisonMode
                    ? Theme.of(context).colorScheme.primary
                    : isInComparison
                        ? Theme.of(context).colorScheme.tertiary
                        : Theme.of(context).dividerColor.withValues(alpha: 0.5),
                width: batch.isSelected && !isComparisonMode || isInComparison
                    ? 2
                    : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  blurRadius: batch.isSelected || isInComparison ? 8 : 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cover image and badges
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: batch.coverImage,
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          height: 160,
                          color: Theme.of(context).colorScheme.surface,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 160,
                          color: Theme.of(context).colorScheme.surface,
                          child: Icon(
                            Icons.image_not_supported,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                    ),

                    // Top badges
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Row(
                        children: [
                          _buildExamTypeBadge(context),
                          if (batch.hasFreeTrialBadge) ...[
                            const SizedBox(width: 8),
                            _buildFreeTrialBadge(context),
                          ],
                        ],
                      ),
                    ),

                    // Selection indicators
                    if (batch.isSelected && !isComparisonMode)
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).shadowColor,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.check,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: 16,
                          ),
                        ),
                      ),

                    // Comparison mode controls
                    if (isComparisonMode)
                      Positioned(
                        top: 12,
                        right: 12,
                        child: isInComparison
                            ? GestureDetector(
                                onTap: onRemoveFromComparison,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiary,
                                    size: 16,
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: onTap,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .cardColor
                                        .withValues(alpha: 0.9),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Theme.of(context).dividerColor,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    size: 16,
                                  ),
                                ),
                              ),
                      ),
                  ],
                ),

                // Content
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Batch name and rating
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              batch.name,
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.getSuccessColor(isDark)
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 14,
                                  color: AppTheme.getSuccessColor(isDark),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  batch.rating.toString(),
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.getSuccessColor(isDark),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Instructor info
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                              imageUrl: batch.instructor.profileImage,
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                width: 32,
                                height: 32,
                                color: Theme.of(context).colorScheme.surface,
                                child: const Icon(Icons.person, size: 16),
                              ),
                              errorWidget: (context, url, error) => Container(
                                width: 32,
                                height: 32,
                                color: Theme.of(context).colorScheme.surface,
                                child: const Icon(Icons.person, size: 16),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  batch.instructor.name,
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                Text(
                                  '${batch.instructor.experience} experience',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            batch.duration,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Key statistics
                      Row(
                        children: [
                          _buildStatItem(
                            context,
                            Icons.people_outline,
                            '${batch.enrollmentCount}',
                            'Students',
                          ),
                          _buildStatItem(
                            context,
                            Icons.library_books_outlined,
                            '${batch.studyMaterialsCount}',
                            'Materials',
                          ),
                          _buildStatItem(
                            context,
                            Icons.quiz_outlined,
                            batch.mockTestFrequency,
                            'Tests',
                          ),
                          _buildStatItem(
                            context,
                            Icons.trending_up,
                            '${batch.successRate.toStringAsFixed(1)}%',
                            'Success',
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Schedule info
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              size: 16,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Live Classes: ${batch.liveClassSchedule}',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Price and actions
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (batch.originalPrice > batch.price)
                                Text(
                                  '₹${batch.originalPrice.toStringAsFixed(0)}',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.6),
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              Row(
                                children: [
                                  Text(
                                    batch.price == 0
                                        ? 'Free'
                                        : '₹${batch.price.toStringAsFixed(0)}',
                                    style: GoogleFonts.inter(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  if (batch.originalPrice > batch.price)
                                    Container(
                                      margin: const EdgeInsets.only(left: 8),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppTheme.getSuccessColor(isDark),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        '${batch.discountPercentage.toStringAsFixed(0)}% OFF',
                                        style: GoogleFonts.inter(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          if (batch.hasFreeTrialBadge && !isComparisonMode)
                            OutlinedButton(
                              onPressed: onStartFreeTrial,
                              child: Text(
                                'Try Free',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          const SizedBox(width: 8),
                          if (!isComparisonMode)
                            ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => BatchDetailsModalWidget(
                                    batch: batch,
                                    onSelect: () {
                                      Navigator.pop(context);
                                      onTap();
                                    },
                                    onStartFreeTrial: () {
                                      Navigator.pop(context);
                                      onStartFreeTrial();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                'View Details',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExamTypeBadge(BuildContext context) {
    Color badgeColor;
    switch (batch.examType) {
      case 'JEE':
        badgeColor = const Color(0xFF3B82F6); // Blue
        break;
      case 'NEET':
        badgeColor = const Color(0xFF10B981); // Green
        break;
      case 'UPSC':
        badgeColor = const Color(0xFF8B5CF6); // Purple
        break;
      case 'CAT':
        badgeColor = const Color(0xFFF59E0B); // Amber
        break;
      default:
        badgeColor = Theme.of(context).colorScheme.primary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        batch.examType,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildFreeTrialBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.getSuccessColor(false),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'FREE TRIAL',
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildStatItem(
      BuildContext context, IconData icon, String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
