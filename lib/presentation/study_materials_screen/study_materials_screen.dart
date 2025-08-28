import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/empty_state_widget.dart';
import './widgets/filter_chip_widget.dart';
import './widgets/filter_modal_widget.dart';
import './widgets/material_card_widget.dart';
import './widgets/search_bar_widget.dart';

class StudyMaterialsScreen extends StatefulWidget {
  const StudyMaterialsScreen({Key? key}) : super(key: key);

  @override
  State<StudyMaterialsScreen> createState() => _StudyMaterialsScreenState();
}

class _StudyMaterialsScreenState extends State<StudyMaterialsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _isMultiSelectMode = false;
  Set<int> _selectedMaterials = {};
  Map<String, dynamic> _activeFilters = {
    'subjects': <String>[],
    'difficulty': null,
    'institutes': <String>[],
    'types': <String>[],
    'showDownloaded': false,
  };

  List<Map<String, dynamic>> _filteredMaterials = [];
  bool _isLoading = false;
  String _searchQuery = '';

  // Mock data for study materials
  final List<Map<String, dynamic>> _allMaterials = [
    {
      'id': 1,
      'title': 'Organic Chemistry - Reaction Mechanisms',
      'subject': 'Chemistry',
      'institute': 'Allen',
      'pageCount': 45,
      'thumbnail':
          'https://images.pexels.com/photos/2280571/pexels-photo-2280571.jpeg?auto=compress&cs=tinysrgb&w=400',
      'isDownloaded': true,
      'isBookmarked': false,
      'progress': 0.7,
      'difficulty': 'Medium',
      'type': 'Notes',
      'uploadDate': DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      'id': 2,
      'title': 'Physics - Electromagnetic Induction',
      'subject': 'Physics',
      'institute': 'PW',
      'pageCount': 32,
      'thumbnail':
          'https://images.pexels.com/photos/220301/pexels-photo-220301.jpeg?auto=compress&cs=tinysrgb&w=400',
      'isDownloaded': false,
      'isBookmarked': true,
      'progress': 0.0,
      'difficulty': 'Hard',
      'type': 'Practice Papers',
      'uploadDate': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'id': 3,
      'title': 'Mathematics - Calculus Integration',
      'subject': 'Mathematics',
      'institute': 'FITJEE',
      'pageCount': 58,
      'thumbnail':
          'https://images.pexels.com/photos/6256065/pexels-photo-6256065.jpeg?auto=compress&cs=tinysrgb&w=400',
      'isDownloaded': true,
      'isBookmarked': true,
      'progress': 0.4,
      'difficulty': 'Expert',
      'type': 'Previous Year',
      'uploadDate': DateTime.now().subtract(const Duration(days: 3)),
    },
    {
      'id': 4,
      'title': 'Biology - Cell Structure and Function',
      'subject': 'Biology',
      'institute': 'Motion',
      'pageCount': 28,
      'thumbnail':
          'https://images.pexels.com/photos/2280549/pexels-photo-2280549.jpeg?auto=compress&cs=tinysrgb&w=400',
      'isDownloaded': false,
      'isBookmarked': false,
      'progress': 0.0,
      'difficulty': 'Easy',
      'type': 'Notes',
      'uploadDate': DateTime.now().subtract(const Duration(hours: 12)),
    },
    {
      'id': 5,
      'title': 'English - Grammar and Comprehension',
      'subject': 'English',
      'institute': 'Vedantu',
      'pageCount': 22,
      'thumbnail':
          'https://images.pexels.com/photos/159711/books-bookstore-book-reading-159711.jpeg?auto=compress&cs=tinysrgb&w=400',
      'isDownloaded': false,
      'isBookmarked': false,
      'progress': 0.0,
      'difficulty': 'Medium',
      'type': 'Mock Tests',
      'uploadDate': DateTime.now().subtract(const Duration(hours: 6)),
    },
    {
      'id': 6,
      'title': 'Physics - Thermodynamics Laws',
      'subject': 'Physics',
      'institute': 'Allen',
      'pageCount': 41,
      'thumbnail':
          'https://images.pexels.com/photos/8566473/pexels-photo-8566473.jpeg?auto=compress&cs=tinysrgb&w=400',
      'isDownloaded': true,
      'isBookmarked': false,
      'progress': 1.0,
      'difficulty': 'Hard',
      'type': 'Notes',
      'uploadDate': DateTime.now().subtract(const Duration(days: 5)),
    },
  ];

  @override
  void initState() {
    super.initState();
    _filteredMaterials = List.from(_allMaterials);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    setState(() {
      _filteredMaterials = _allMaterials.where((material) {
        // Search query filter
        if (_searchQuery.isNotEmpty) {
          final query = _searchQuery.toLowerCase();
          final title = (material['title'] as String).toLowerCase();
          final subject = (material['subject'] as String).toLowerCase();
          if (!title.contains(query) && !subject.contains(query)) {
            return false;
          }
        }

        // Subject filter
        final selectedSubjects = _activeFilters['subjects'] as List<String>;
        if (selectedSubjects.isNotEmpty &&
            !selectedSubjects.contains(material['subject'])) {
          return false;
        }

        // Difficulty filter
        final selectedDifficulty = _activeFilters['difficulty'] as String?;
        if (selectedDifficulty != null &&
            material['difficulty'] != selectedDifficulty) {
          return false;
        }

        // Institute filter
        final selectedInstitutes = _activeFilters['institutes'] as List<String>;
        if (selectedInstitutes.isNotEmpty &&
            !selectedInstitutes.contains(material['institute'])) {
          return false;
        }

        // Type filter
        final selectedTypes = _activeFilters['types'] as List<String>;
        if (selectedTypes.isNotEmpty &&
            !selectedTypes.contains(material['type'])) {
          return false;
        }

        // Download status filter
        final showDownloaded = _activeFilters['showDownloaded'] as bool;
        if (showDownloaded && !(material['isDownloaded'] as bool)) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
    _applyFilters();
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterModalWidget(
        currentFilters: _activeFilters,
        onApplyFilters: (filters) {
          setState(() {
            _activeFilters = filters;
          });
          _applyFilters();
        },
        onResetFilters: () {
          setState(() {
            _activeFilters = {
              'subjects': <String>[],
              'difficulty': null,
              'institutes': <String>[],
              'types': <String>[],
              'showDownloaded': false,
            };
          });
          _applyFilters();
        },
      ),
    );
  }

  void _toggleMaterialSelection(int materialId) {
    setState(() {
      if (_selectedMaterials.contains(materialId)) {
        _selectedMaterials.remove(materialId);
        if (_selectedMaterials.isEmpty) {
          _isMultiSelectMode = false;
        }
      } else {
        _selectedMaterials.add(materialId);
      }
    });
  }

  void _startMultiSelectMode(int materialId) {
    setState(() {
      _isMultiSelectMode = true;
      _selectedMaterials.add(materialId);
    });
  }

  void _exitMultiSelectMode() {
    setState(() {
      _isMultiSelectMode = false;
      _selectedMaterials.clear();
    });
  }

  void _downloadMaterial(Map<String, dynamic> material) {
    // Simulate download
    setState(() {
      final index = _allMaterials.indexWhere((m) => m['id'] == material['id']);
      if (index != -1) {
        _allMaterials[index]['isDownloaded'] = true;
      }
    });
    _applyFilters();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${material['title']} downloaded successfully'),
        backgroundColor: AppTheme.getSuccessColor(true),
      ),
    );
  }

  void _toggleBookmark(Map<String, dynamic> material) {
    setState(() {
      final index = _allMaterials.indexWhere((m) => m['id'] == material['id']);
      if (index != -1) {
        _allMaterials[index]['isBookmarked'] =
            !(_allMaterials[index]['isBookmarked'] as bool);
      }
    });
    _applyFilters();
  }

  void _openMaterial(Map<String, dynamic> material) {
    Navigator.pushNamed(context, '/pdf-viewer-screen', arguments: material);
  }

  void _batchDownload() {
    final selectedMaterialsList = _allMaterials
        .where((m) => _selectedMaterials.contains(m['id']))
        .toList();

    setState(() {
      for (final material in selectedMaterialsList) {
        final index =
            _allMaterials.indexWhere((m) => m['id'] == material['id']);
        if (index != -1) {
          _allMaterials[index]['isDownloaded'] = true;
        }
      }
    });

    _exitMultiSelectMode();
    _applyFilters();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${selectedMaterialsList.length} materials downloaded'),
        backgroundColor: AppTheme.getSuccessColor(true),
      ),
    );
  }

  Future<void> _refreshMaterials() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate network refresh
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Materials refreshed'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  List<String> _getActiveFilterLabels() {
    List<String> labels = [];

    final subjects = _activeFilters['subjects'] as List<String>;
    if (subjects.isNotEmpty) {
      labels.add('Subject (${subjects.length})');
    }

    final difficulty = _activeFilters['difficulty'] as String?;
    if (difficulty != null) {
      labels.add('Difficulty');
    }

    final institutes = _activeFilters['institutes'] as List<String>;
    if (institutes.isNotEmpty) {
      labels.add('Institute (${institutes.length})');
    }

    final types = _activeFilters['types'] as List<String>;
    if (types.isNotEmpty) {
      labels.add('Type (${types.length})');
    }

    if (_activeFilters['showDownloaded'] as bool) {
      labels.add('Downloaded');
    }

    return labels;
  }

  @override
  Widget build(BuildContext context) {
    final activeFilterLabels = _getActiveFilterLabels();

    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: _isMultiSelectMode
          ? AppBar(
              leading: IconButton(
                onPressed: _exitMultiSelectMode,
                icon: CustomIconWidget(
                  iconName: 'close',
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                  size: 6.w,
                ),
              ),
              title: Text('${_selectedMaterials.length} selected'),
              actions: [
                IconButton(
                  onPressed: _batchDownload,
                  icon: CustomIconWidget(
                    iconName: 'download',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 6.w,
                  ),
                ),
              ],
            )
          : AppBar(
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: CustomIconWidget(
                  iconName: 'arrow_back',
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                  size: 6.w,
                ),
              ),
              title: const Text('Study Materials'),
              actions: [
                IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/profile-screen'),
                  icon: CustomIconWidget(
                    iconName: 'person',
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                    size: 6.w,
                  ),
                ),
              ],
            ),
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            SearchBarWidget(
              controller: _searchController,
              onChanged: _onSearchChanged,
              onFilterTap: _showFilterModal,
              onVoiceSearch: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Voice search activated'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            ),

            // Active filters
            if (activeFilterLabels.isNotEmpty)
              Container(
                height: 6.h,
                margin: EdgeInsets.symmetric(vertical: 1.h),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  itemCount: activeFilterLabels.length,
                  itemBuilder: (context, index) {
                    return FilterChipWidget(
                      label: activeFilterLabels[index],
                      isSelected: true,
                      onTap: _showFilterModal,
                    );
                  },
                ),
              ),

            // Materials list
            Expanded(
              child: _filteredMaterials.isEmpty
                  ? EmptyStateWidget(
                      title: _searchQuery.isNotEmpty ||
                              activeFilterLabels.isNotEmpty
                          ? 'No materials found'
                          : 'No study materials available',
                      subtitle: _searchQuery.isNotEmpty ||
                              activeFilterLabels.isNotEmpty
                          ? 'Try adjusting your search or filters to find more materials.'
                          : 'Check back later for new study materials from your selected batch.',
                      buttonText: 'Clear Filters',
                      onButtonPressed: activeFilterLabels.isNotEmpty
                          ? () {
                              setState(() {
                                _activeFilters = {
                                  'subjects': <String>[],
                                  'difficulty': null,
                                  'institutes': <String>[],
                                  'types': <String>[],
                                  'showDownloaded': false,
                                };
                                _searchQuery = '';
                                _searchController.clear();
                              });
                              _applyFilters();
                            }
                          : null,
                      illustrationUrl:
                          'https://images.pexels.com/photos/159711/books-bookstore-book-reading-159711.jpeg?auto=compress&cs=tinysrgb&w=600',
                    )
                  : RefreshIndicator(
                      onRefresh: _refreshMaterials,
                      color: AppTheme.lightTheme.colorScheme.primary,
                      child: ListView.builder(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: _filteredMaterials.length,
                        itemBuilder: (context, index) {
                          final material = _filteredMaterials[index];
                          final materialId = material['id'] as int;
                          final isSelected =
                              _selectedMaterials.contains(materialId);

                          return MaterialCardWidget(
                            material: material,
                            isSelected: isSelected,
                            onTap: () {
                              if (_isMultiSelectMode) {
                                _toggleMaterialSelection(materialId);
                              } else {
                                _openMaterial(material);
                              }
                            },
                            onBookmark: () => _toggleBookmark(material),
                            onDownload: () => _downloadMaterial(material),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: !_isMultiSelectMode && _filteredMaterials.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                // Show recently viewed materials
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Recently viewed materials'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              child: CustomIconWidget(
                iconName: 'history',
                color: AppTheme.lightTheme.colorScheme.onPrimary,
                size: 6.w,
              ),
            )
          : null,
    );
  }
}
