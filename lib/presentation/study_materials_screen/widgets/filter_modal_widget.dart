import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FilterModalWidget extends StatefulWidget {
  final Map<String, dynamic> currentFilters;
  final Function(Map<String, dynamic>) onApplyFilters;
  final VoidCallback onResetFilters;

  const FilterModalWidget({
    Key? key,
    required this.currentFilters,
    required this.onApplyFilters,
    required this.onResetFilters,
  }) : super(key: key);

  @override
  State<FilterModalWidget> createState() => _FilterModalWidgetState();
}

class _FilterModalWidgetState extends State<FilterModalWidget> {
  late Map<String, dynamic> _tempFilters;

  final List<String> subjects = [
    'Physics',
    'Chemistry',
    'Mathematics',
    'Biology',
    'English'
  ];
  final List<String> difficulties = ['Easy', 'Medium', 'Hard', 'Expert'];
  final List<String> institutes = [
    'PW',
    'Allen',
    'FITJEE',
    'Motion',
    'Vedantu',
    'Unacademy'
  ];
  final List<String> types = [
    'Notes',
    'Practice Papers',
    'Previous Year',
    'Mock Tests'
  ];

  @override
  void initState() {
    super.initState();
    _tempFilters = Map<String, dynamic>.from(widget.currentFilters);
  }

  Widget _buildFilterSection({
    required String title,
    required List<String> options,
    required String filterKey,
    bool isMultiSelect = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: options.map((option) {
            final bool isSelected = isMultiSelect
                ? (_tempFilters[filterKey] as List<String>?)
                        ?.contains(option) ??
                    false
                : _tempFilters[filterKey] == option;

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isMultiSelect) {
                    final List<String> currentList =
                        List<String>.from(_tempFilters[filterKey] ?? []);
                    if (isSelected) {
                      currentList.remove(option);
                    } else {
                      currentList.add(option);
                    }
                    _tempFilters[filterKey] = currentList;
                  } else {
                    _tempFilters[filterKey] = isSelected ? null : option;
                  }
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.lightTheme.colorScheme.primary
                      : AppTheme.lightTheme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.lightTheme.colorScheme.primary
                        : AppTheme.lightTheme.colorScheme.outline
                            .withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  option,
                  style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                    color: isSelected
                        ? AppTheme.lightTheme.colorScheme.onPrimary
                        : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 10.w,
            height: 0.5.h,
            margin: EdgeInsets.symmetric(vertical: 1.h),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant
                  .withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter Materials',
                  style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: CustomIconWidget(
                    iconName: 'close',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 6.w,
                  ),
                ),
              ],
            ),
          ),

          Divider(
            height: 2.h,
            color:
                AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
          ),

          // Filter content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFilterSection(
                    title: 'Subject',
                    options: subjects,
                    filterKey: 'subjects',
                  ),
                  SizedBox(height: 3.h),

                  _buildFilterSection(
                    title: 'Difficulty Level',
                    options: difficulties,
                    filterKey: 'difficulty',
                    isMultiSelect: false,
                  ),
                  SizedBox(height: 3.h),

                  _buildFilterSection(
                    title: 'Institute',
                    options: institutes,
                    filterKey: 'institutes',
                  ),
                  SizedBox(height: 3.h),

                  _buildFilterSection(
                    title: 'Material Type',
                    options: types,
                    filterKey: 'types',
                  ),
                  SizedBox(height: 3.h),

                  // Download status
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Download Status',
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        children: [
                          Checkbox(
                            value: _tempFilters['showDownloaded'] ?? false,
                            onChanged: (value) {
                              setState(() {
                                _tempFilters['showDownloaded'] = value ?? false;
                              });
                            },
                          ),
                          Text(
                            'Show only downloaded materials',
                            style: AppTheme.lightTheme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),

          // Action buttons
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              border: Border(
                top: BorderSide(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.2),
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      widget.onResetFilters();
                      Navigator.pop(context);
                    },
                    child: const Text('Reset'),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onApplyFilters(_tempFilters);
                      Navigator.pop(context);
                    },
                    child: const Text('Apply Filters'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
