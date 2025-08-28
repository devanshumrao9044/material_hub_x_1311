import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_export.dart';
import './widgets/batch_card_widget.dart';
import './widgets/batch_comparison_widget.dart';
import './widgets/batch_filter_modal_widget.dart';
import './widgets/batch_search_bar_widget.dart';
import './widgets/selected_batch_bottom_bar_widget.dart';

class BatchSelectionScreen extends StatefulWidget {
  const BatchSelectionScreen({super.key});

  @override
  State<BatchSelectionScreen> createState() => _BatchSelectionScreenState();
}

class _BatchSelectionScreenState extends State<BatchSelectionScreen>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<BatchInfo> _allBatches = [];
  List<BatchInfo> _filteredBatches = [];
  String _searchQuery = '';
  List<String> _selectedFilters = [];
  BatchInfo? _selectedBatch;
  List<BatchInfo> _comparisonBatches = [];
  bool _isComparisonMode = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMockBatches();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMockBatches() {
    setState(() {
      _isLoading = true;
    });

    // Mock data for demonstration
    _allBatches = [
      BatchInfo(
        id: '1',
        name: 'JEE Advanced Pro Batch',
        examType: 'JEE',
        duration: '12 months',
        instructor: InstructorInfo(
          name: 'Dr. Rajesh Sharma',
          profileImage:
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
          experience: '15 years',
          rating: 4.8,
        ),
        coverImage:
            'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=400&h=200&fit=crop',
        enrollmentCount: 2847,
        liveClassSchedule: 'Mon, Wed, Fri - 7:00 PM',
        studyMaterialsCount: 450,
        mockTestFrequency: 'Weekly',
        successRate: 85.6,
        rating: 4.8,
        price: 15999,
        originalPrice: 19999,
        hasFreeTrialBadge: true,
        isSelected: false,
        keyFeatures: [
          'Live interactive classes',
          'Recorded sessions access',
          'Personal doubt clearing',
          'Performance analytics'
        ],
        syllabus:
            'Complete JEE syllabus coverage including Physics, Chemistry, and Mathematics',
        testimonials: [
          'Best batch for JEE preparation! Got AIR 150. - Arjun K.',
          'Excellent teaching methodology. - Priya S.'
        ],
        discountPercentage: 20,
      ),
      BatchInfo(
        id: '2',
        name: 'NEET Medical Foundation',
        examType: 'NEET',
        duration: '18 months',
        instructor: InstructorInfo(
          name: 'Dr. Priya Gupta',
          profileImage:
              'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=150&h=150&fit=crop&crop=face',
          experience: '12 years',
          rating: 4.7,
        ),
        coverImage:
            'https://images.unsplash.com/photo-1576091160399-112ba8d25d1f?w=400&h=200&fit=crop',
        enrollmentCount: 1956,
        liveClassSchedule: 'Daily - 6:00 PM',
        studyMaterialsCount: 520,
        mockTestFrequency: 'Bi-weekly',
        successRate: 78.4,
        rating: 4.7,
        price: 12999,
        originalPrice: 16999,
        hasFreeTrialBadge: true,
        isSelected: false,
        keyFeatures: [
          'NCERT focused approach',
          'Medical entrance strategies',
          'Regular assessments',
          'Career guidance'
        ],
        syllabus:
            'Complete NEET syllabus with Biology, Physics, and Chemistry focus',
        testimonials: [
          'Secured admission in AIIMS! Thank you. - Ravi M.',
          'Great faculty and support system. - Anita R.'
        ],
        discountPercentage: 25,
      ),
      BatchInfo(
        id: '3',
        name: 'UPSC Prelims + Mains',
        examType: 'UPSC',
        duration: '24 months',
        instructor: InstructorInfo(
          name: 'Shri Amit Kumar',
          profileImage:
              'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
          experience: '20 years',
          rating: 4.9,
        ),
        coverImage:
            'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&h=200&fit=crop',
        enrollmentCount: 3421,
        liveClassSchedule: 'Tue, Thu, Sat - 8:00 PM',
        studyMaterialsCount: 680,
        mockTestFrequency: 'Monthly',
        successRate: 92.1,
        rating: 4.9,
        price: 25999,
        originalPrice: 32999,
        hasFreeTrialBadge: false,
        isSelected: false,
        keyFeatures: [
          'Comprehensive coverage',
          'Answer writing practice',
          'Current affairs updates',
          'Interview preparation'
        ],
        syllabus:
            'Complete UPSC curriculum with GS Papers and Optional subjects',
        testimonials: [
          'Cleared UPSC in first attempt! - Deepak S.',
          'Exceptional guidance for interview. - Meera P.'
        ],
        discountPercentage: 15,
      ),
      BatchInfo(
        id: '4',
        name: 'CAT MBA Prep Elite',
        examType: 'CAT',
        duration: '10 months',
        instructor: InstructorInfo(
          name: 'Prof. Neha Agarwal',
          profileImage:
              'https://images.unsplash.com/photo-1494790108755-2616b612b5ac?w=150&h=150&fit=crop&crop=face',
          experience: '8 years',
          rating: 4.6,
        ),
        coverImage:
            'https://images.unsplash.com/photo-1507679799987-c73779587ccf?w=400&h=200&fit=crop',
        enrollmentCount: 1243,
        liveClassSchedule: 'Mon, Wed, Fri - 9:00 PM',
        studyMaterialsCount: 320,
        mockTestFrequency: 'Weekly',
        successRate: 73.8,
        rating: 4.6,
        price: 8999,
        originalPrice: 11999,
        hasFreeTrialBadge: true,
        isSelected: false,
        keyFeatures: [
          'Quantitative aptitude focus',
          'Logical reasoning techniques',
          'Verbal ability enhancement',
          'Mock interviews'
        ],
        syllabus: 'Complete CAT preparation with QA, LR, and VA sections',
        testimonials: [
          'Got into IIM Bangalore! - Rohit K.',
          'Great preparation strategy. - Kavya L.'
        ],
        discountPercentage: 30,
      ),
    ];

    _filteredBatches = List.from(_allBatches);

    setState(() {
      _isLoading = false;
    });
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
      _filterBatches();
    });
  }

  void _filterBatches() {
    _filteredBatches = _allBatches.where((batch) {
      final matchesSearch = _searchQuery.isEmpty ||
          batch.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          batch.examType.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          batch.instructor.name
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());

      final matchesFilters = _selectedFilters.isEmpty ||
          _selectedFilters.contains(batch.examType) ||
          _selectedFilters.any((filter) => batch.duration.contains(filter));

      return matchesSearch && matchesFilters;
    }).toList();
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BatchFilterModalWidget(
        selectedFilters: _selectedFilters,
        onFiltersChanged: (filters) {
          setState(() {
            _selectedFilters = filters;
            _filterBatches();
          });
        },
      ),
    );
  }

  void _onBatchSelected(BatchInfo batch) {
    setState(() {
      // Reset previous selection
      for (var b in _allBatches) {
        b.isSelected = false;
      }
      // Set new selection
      batch.isSelected = true;
      _selectedBatch = batch;
    });
  }

  void _toggleComparisonMode() {
    setState(() {
      _isComparisonMode = !_isComparisonMode;
      if (!_isComparisonMode) {
        _comparisonBatches.clear();
      }
    });
  }

  void _addToComparison(BatchInfo batch) {
    if (_comparisonBatches.length < 3 && !_comparisonBatches.contains(batch)) {
      setState(() {
        _comparisonBatches.add(batch);
      });
    }
  }

  void _removeFromComparison(BatchInfo batch) {
    setState(() {
      _comparisonBatches.remove(batch);
    });
  }

  void _showComparison() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BatchComparisonWidget(
        batches: _comparisonBatches,
        onClose: () => Navigator.pop(context),
      ),
    );
  }

  void _continueWithSelectedBatch() {
    if (_selectedBatch != null) {
      if (_selectedBatch!.price > 0) {
        // Navigate to payment screen (not implemented)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Payment flow for ${_selectedBatch!.name} would be implemented here',
              style: GoogleFonts.inter(fontWeight: FontWeight.w500),
            ),
            backgroundColor: AppTheme.primaryLight,
          ),
        );
      } else {
        // Navigate to dashboard for free batch
        Navigator.pushReplacementNamed(context, AppRoutes.homeDashboard);
      }
    }
  }

  void _startFreeTrial(BatchInfo batch) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Starting free trial for ${batch.name}',
          style: GoogleFonts.inter(fontWeight: FontWeight.w500),
        ),
        backgroundColor: AppTheme.successLight,
      ),
    );
    Navigator.pushReplacementNamed(context, AppRoutes.homeDashboard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  // Header with search and filter
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).shadowColor,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.arrow_back),
                            ),
                            Text(
                              'Select Your Batch',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const Spacer(),
                            if (_isComparisonMode)
                              TextButton(
                                onPressed: _toggleComparisonMode,
                                child: Text(
                                  'Exit Compare',
                                  style: GoogleFonts.inter(
                                    color: AppTheme.errorLight,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            else
                              TextButton(
                                onPressed: _toggleComparisonMode,
                                child: Text(
                                  'Compare',
                                  style: GoogleFonts.inter(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        BatchSearchBarWidget(
                          controller: _searchController,
                          onFilterPressed: _showFilterModal,
                          hasActiveFilters: _selectedFilters.isNotEmpty,
                        ),
                        if (_isComparisonMode &&
                            _comparisonBatches.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withValues(alpha: 0.3),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.compare_arrows,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Selected ${_comparisonBatches.length} batches for comparison',
                                  style: GoogleFonts.inter(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                const Spacer(),
                                if (_comparisonBatches.length >= 2)
                                  TextButton(
                                    onPressed: _showComparison,
                                    child: Text(
                                      'Compare Now',
                                      style: GoogleFonts.inter(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Batch list
                  Expanded(
                    child: _filteredBatches.isEmpty
                        ? _buildEmptyState()
                        : ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            itemCount: _filteredBatches.length,
                            itemBuilder: (context, index) {
                              final batch = _filteredBatches[index];
                              return BatchCardWidget(
                                batch: batch,
                                isComparisonMode: _isComparisonMode,
                                isInComparison:
                                    _comparisonBatches.contains(batch),
                                onTap: () => _isComparisonMode
                                    ? _addToComparison(batch)
                                    : _onBatchSelected(batch),
                                onStartFreeTrial: () => _startFreeTrial(batch),
                                onRemoveFromComparison: () =>
                                    _removeFromComparison(batch),
                              );
                            },
                          ),
                  ),
                ],
              ),
      ),

      // Bottom sticky bar
      bottomNavigationBar: _selectedBatch != null && !_isComparisonMode
          ? SelectedBatchBottomBarWidget(
              selectedBatch: _selectedBatch!,
              onContinue: _continueWithSelectedBatch,
            )
          : null,
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No batches found',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.7),
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.6),
                ),
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () {
              setState(() {
                _searchController.clear();
                _selectedFilters.clear();
                _searchQuery = '';
                _filterBatches();
              });
            },
            child: Text(
              'Clear All Filters',
              style: GoogleFonts.inter(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Data models for batch information
class BatchInfo {
  final String id;
  final String name;
  final String examType;
  final String duration;
  final InstructorInfo instructor;
  final String coverImage;
  final int enrollmentCount;
  final String liveClassSchedule;
  final int studyMaterialsCount;
  final String mockTestFrequency;
  final double successRate;
  final double rating;
  final double price;
  final double originalPrice;
  final bool hasFreeTrialBadge;
  bool isSelected;
  final List<String> keyFeatures;
  final String syllabus;
  final List<String> testimonials;
  final double discountPercentage;

  BatchInfo({
    required this.id,
    required this.name,
    required this.examType,
    required this.duration,
    required this.instructor,
    required this.coverImage,
    required this.enrollmentCount,
    required this.liveClassSchedule,
    required this.studyMaterialsCount,
    required this.mockTestFrequency,
    required this.successRate,
    required this.rating,
    required this.price,
    required this.originalPrice,
    required this.hasFreeTrialBadge,
    required this.isSelected,
    required this.keyFeatures,
    required this.syllabus,
    required this.testimonials,
    required this.discountPercentage,
  });
}

class InstructorInfo {
  final String name;
  final String profileImage;
  final String experience;
  final double rating;

  InstructorInfo({
    required this.name,
    required this.profileImage,
    required this.experience,
    required this.rating,
  });
}
