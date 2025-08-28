import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/pdf_bottom_toolbar_widget.dart';
import './widgets/pdf_note_widget.dart';
import './widgets/pdf_search_widget.dart';
import './widgets/pdf_security_overlay_widget.dart';
import './widgets/pdf_thumbnails_widget.dart';
import './widgets/pdf_toolbar_widget.dart';

class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({super.key});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen>
    with TickerProviderStateMixin {
  // PDF viewing state
  int _currentPage = 1;
  int _totalPages = 45;
  double _zoomLevel = 1.0;
  bool _isBookmarked = false;

  // UI state
  bool _showSearch = false;
  bool _showThumbnails = false;
  bool _showNote = false;
  bool _isHighlightActive = false;
  bool _isNoteActive = false;
  bool _isScreenRecordingDetected = false;

  // Search state
  int _currentSearchMatch = 0;
  int _totalSearchMatches = 0;
  String _searchQuery = '';

  // XP tracking
  DateTime _sessionStartTime = DateTime.now();
  int _studyTimeMinutes = 0;

  // Mock document data
  final Map<String, dynamic> _documentData = {
    "id": "doc_001",
    "title": "IIT JEE Physics - Mechanics Chapter 1",
    "subject": "Physics",
    "chapter": "Mechanics",
    "batch": "IIT JEE 2024",
    "institute": "Allen Kota",
    "totalPages": 45,
    "downloadUrl": "https://example.com/physics-mechanics.pdf",
    "isDownloaded": true,
    "lastReadPage": 1,
    "readingProgress": 15.5,
    "bookmarks": [5, 12, 23, 34],
    "notes": {
      "5": "Important formula for velocity",
      "12": "Remember this concept for exam",
      "23": "Practice more problems on this topic"
    },
    "highlights": [
      {"page": 5, "text": "Newton's First Law", "color": "yellow"},
      {"page": 12, "text": "Kinematic equations", "color": "green"},
    ]
  };

  final List<Map<String, dynamic>> _tableOfContents = [
    {"title": "Introduction to Mechanics", "page": 1},
    {"title": "Newton's Laws of Motion", "page": 5},
    {"title": "Kinematic Equations", "page": 12},
    {"title": "Work and Energy", "page": 18},
    {"title": "Momentum and Collisions", "page": 25},
    {"title": "Rotational Motion", "page": 32},
    {"title": "Gravitation", "page": 38},
    {"title": "Practice Problems", "page": 42},
  ];

  @override
  void initState() {
    super.initState();
    _initializePdfViewer();
    _startStudySession();
  }

  void _initializePdfViewer() {
    setState(() {
      _currentPage = (_documentData["lastReadPage"] as int?) ?? 1;
      _totalPages = (_documentData["totalPages"] as int?) ?? 45;
      _isBookmarked =
          (_documentData["bookmarks"] as List?)?.contains(_currentPage) ??
              false;
    });

    // Simulate screen recording detection
    _detectScreenRecording();
  }

  void _startStudySession() {
    _sessionStartTime = DateTime.now();
    // Start XP tracking timer
    Future.delayed(const Duration(minutes: 2), _awardXP);
  }

  void _awardXP() {
    if (mounted) {
      _studyTimeMinutes += 2;
      // Award 1 XP for every 2 minutes
      print('XP Awarded: 1 (Total study time: $_studyTimeMinutes minutes)');
      Future.delayed(const Duration(minutes: 2), _awardXP);
    }
  }

  void _detectScreenRecording() {
    // Simulate screen recording detection
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isScreenRecordingDetected = false; // Set to true to test warning
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Custom app bar
                _buildCustomAppBar(),

                // Top toolbar
                _showSearch
                    ? PdfSearchWidget(
                        onSearch: _handleSearch,
                        onPrevious: _handlePreviousMatch,
                        onNext: _handleNextMatch,
                        onClose: _closeSearch,
                        currentMatch: _currentSearchMatch,
                        totalMatches: _totalSearchMatches,
                      )
                    : PdfToolbarWidget(
                        currentPage: _currentPage,
                        totalPages: _totalPages,
                        zoomLevel: _zoomLevel,
                        isBookmarked: _isBookmarked,
                        onZoomIn: _handleZoomIn,
                        onZoomOut: _handleZoomOut,
                        onBookmarkToggle: _toggleBookmark,
                        onSearch: _openSearch,
                        onTableOfContents: _showTableOfContents,
                      ),

                // PDF content area
                Expanded(
                  child: _buildPdfContent(),
                ),

                // Bottom toolbar
                PdfBottomToolbarWidget(
                  onHighlight: _toggleHighlight,
                  onNote: _toggleNote,
                  onSearch: _openSearch,
                  onThumbnails: _showPageThumbnails,
                  isHighlightActive: _isHighlightActive,
                  isNoteActive: _isNoteActive,
                ),
              ],
            ),

            // Security overlay and watermark
            PdfSecurityOverlayWidget(
              userEmail: "student@example.com",
              isScreenRecordingDetected: _isScreenRecordingDetected,
              onDismiss: _handleSecurityDismiss,
            ),

            // Bottom sheets
            if (_showThumbnails) _buildThumbnailsBottomSheet(),
            if (_showNote) _buildNoteBottomSheet(),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return Container(
      height: 8.h,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: _handleBackPress,
            child: Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.3),
                ),
              ),
              child: CustomIconWidget(
                iconName: 'arrow_back',
                size: 24,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _documentData["title"] as String? ?? "Document",
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "${_documentData["subject"]} • ${_documentData["institute"]}",
                  style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurface
                        .withValues(alpha: 0.6),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: _showActionMenu,
            child: Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.3),
                ),
              ),
              child: CustomIconWidget(
                iconName: 'more_vert',
                size: 24,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPdfContent() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GestureDetector(
          onDoubleTap: _handleDoubleTap,
          child: InteractiveViewer(
            minScale: 0.5,
            maxScale: 3.0,
            onInteractionUpdate: (details) {
              setState(() {
                _zoomLevel = details.scale;
              });
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  // PDF page header
                  Container(
                    padding: EdgeInsets.all(4.w),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 1.h),
                          decoration: BoxDecoration(
                            color: AppTheme.lightTheme.colorScheme.primary
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Page $_currentPage',
                            style: AppTheme.lightTheme.textTheme.labelMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.lightTheme.colorScheme.primary,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 1.h),
                          decoration: BoxDecoration(
                            color: AppTheme
                                .lightTheme.colorScheme.surfaceContainerHighest
                                .withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${(_documentData["readingProgress"] as double? ?? 0.0).toStringAsFixed(1)}% Complete',
                            style: AppTheme.lightTheme.textTheme.labelSmall
                                ?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // PDF content simulation
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      padding: EdgeInsets.all(4.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getPageTitle(),
                            style: AppTheme.lightTheme.textTheme.headlineSmall
                                ?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppTheme.lightTheme.colorScheme.primary,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildContentSection("Introduction",
                                      "This chapter covers the fundamental concepts of mechanics in physics. Understanding these principles is crucial for solving complex problems in competitive exams like IIT JEE."),
                                  SizedBox(height: 2.h),
                                  _buildContentSection("Key Concepts",
                                      "• Newton's Laws of Motion\n• Kinematic Equations\n• Work and Energy\n• Momentum Conservation\n• Rotational Dynamics"),
                                  SizedBox(height: 2.h),
                                  _buildHighlightedText(
                                      "Important Formula: v² = u² + 2as"),
                                  SizedBox(height: 2.h),
                                  _buildContentSection("Practice Problems",
                                      "Solve the following problems to test your understanding of the concepts covered in this chapter."),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Page navigation
                  Container(
                    padding: EdgeInsets.all(4.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _currentPage > 1
                            ? GestureDetector(
                                onTap: _previousPage,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4.w, vertical: 1.h),
                                  decoration: BoxDecoration(
                                    color:
                                        AppTheme.lightTheme.colorScheme.primary,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomIconWidget(
                                        iconName: 'arrow_back',
                                        size: 16,
                                        color: AppTheme
                                            .lightTheme.colorScheme.onPrimary,
                                      ),
                                      SizedBox(width: 2.w),
                                      Text(
                                        'Previous',
                                        style: AppTheme
                                            .lightTheme.textTheme.labelMedium
                                            ?.copyWith(
                                          color: AppTheme
                                              .lightTheme.colorScheme.onPrimary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        _currentPage < _totalPages
                            ? GestureDetector(
                                onTap: _nextPage,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4.w, vertical: 1.h),
                                  decoration: BoxDecoration(
                                    color:
                                        AppTheme.lightTheme.colorScheme.primary,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Next',
                                        style: AppTheme
                                            .lightTheme.textTheme.labelMedium
                                            ?.copyWith(
                                          color: AppTheme
                                              .lightTheme.colorScheme.onPrimary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 2.w),
                                      CustomIconWidget(
                                        iconName: 'arrow_forward',
                                        size: 16,
                                        color: AppTheme
                                            .lightTheme.colorScheme.onPrimary,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContentSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.lightTheme.colorScheme.secondary,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          content,
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            height: 1.6,
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildHighlightedText(String text) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.yellow.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.yellow.withValues(alpha: 0.5),
        ),
      ),
      child: Text(
        text,
        style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppTheme.lightTheme.colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget _buildThumbnailsBottomSheet() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: PdfThumbnailsWidget(
        totalPages: _totalPages,
        currentPage: _currentPage,
        onPageSelected: _goToPage,
        onClose: _closeThumbnails,
      ),
    );
  }

  Widget _buildNoteBottomSheet() {
    final currentNote = (_documentData["notes"]
            as Map<String, dynamic>?)?[_currentPage.toString()] as String? ??
        '';

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: PdfNoteWidget(
        initialNote: currentNote,
        pageNumber: _currentPage,
        onSaveNote: _saveNote,
        onClose: _closeNote,
      ),
    );
  }

  // Event handlers
  void _handleBackPress() {
    _showExitConfirmation();
  }

  void _showExitConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Exit Document?',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Your reading progress will be saved. Are you sure you want to exit?',
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('Exit'),
          ),
        ],
      ),
    );
  }

  void _showActionMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CustomIconWidget(
                  iconName: 'share',
                  size: 24,
                  color: AppTheme.lightTheme.colorScheme.onSurface),
              title: Text('Share Progress'),
              onTap: () {
                Navigator.pop(context);
                _shareProgress();
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                  iconName: 'download',
                  size: 24,
                  color: AppTheme.lightTheme.colorScheme.onSurface),
              title: Text('Download for Offline'),
              onTap: () {
                Navigator.pop(context);
                _downloadDocument();
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                  iconName: 'settings',
                  size: 24,
                  color: AppTheme.lightTheme.colorScheme.onSurface),
              title: Text('Reading Settings'),
              onTap: () {
                Navigator.pop(context);
                _showReadingSettings();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleZoomIn() {
    setState(() {
      _zoomLevel = (_zoomLevel + 0.25).clamp(0.5, 3.0);
    });
  }

  void _handleZoomOut() {
    setState(() {
      _zoomLevel = (_zoomLevel - 0.25).clamp(0.5, 3.0);
    });
  }

  void _handleDoubleTap() {
    setState(() {
      _zoomLevel = _zoomLevel == 1.0 ? 1.5 : 1.0;
    });
  }

  void _toggleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });

    HapticFeedback.lightImpact();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isBookmarked ? 'Page bookmarked' : 'Bookmark removed'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _openSearch() {
    setState(() {
      _showSearch = true;
    });
  }

  void _closeSearch() {
    setState(() {
      _showSearch = false;
      _searchQuery = '';
      _currentSearchMatch = 0;
      _totalSearchMatches = 0;
    });
  }

  void _handleSearch(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isNotEmpty) {
        // Simulate search results
        _totalSearchMatches = 8;
        _currentSearchMatch = 1;
      } else {
        _totalSearchMatches = 0;
        _currentSearchMatch = 0;
      }
    });
  }

  void _handlePreviousMatch() {
    if (_currentSearchMatch > 1) {
      setState(() {
        _currentSearchMatch--;
      });
    }
  }

  void _handleNextMatch() {
    if (_currentSearchMatch < _totalSearchMatches) {
      setState(() {
        _currentSearchMatch++;
      });
    }
  }

  void _showTableOfContents() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: 60.h,
        padding: EdgeInsets.all(4.w),
        child: Column(
          children: [
            Text(
              'Table of Contents',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            Expanded(
              child: ListView.builder(
                itemCount: _tableOfContents.length,
                itemBuilder: (context, index) {
                  final item = _tableOfContents[index];
                  return ListTile(
                    title: Text(item["title"] as String),
                    trailing: Text('Page ${item["page"]}'),
                    onTap: () {
                      Navigator.pop(context);
                      _goToPage(item["page"] as int);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleHighlight() {
    setState(() {
      _isHighlightActive = !_isHighlightActive;
      if (_isHighlightActive) _isNoteActive = false;
    });
  }

  void _toggleNote() {
    setState(() {
      _showNote = true;
      _isNoteActive = true;
      _isHighlightActive = false;
    });
  }

  void _closeNote() {
    setState(() {
      _showNote = false;
      _isNoteActive = false;
    });
  }

  void _saveNote(String note) {
    // Save note logic here
    print('Note saved for page $_currentPage: $note');
  }

  void _showPageThumbnails() {
    setState(() {
      _showThumbnails = true;
    });
  }

  void _closeThumbnails() {
    setState(() {
      _showThumbnails = false;
    });
  }

  void _goToPage(int page) {
    setState(() {
      _currentPage = page;
      _isBookmarked =
          (_documentData["bookmarks"] as List?)?.contains(page) ?? false;
    });
    _closeThumbnails();
  }

  void _previousPage() {
    if (_currentPage > 1) {
      _goToPage(_currentPage - 1);
    }
  }

  void _nextPage() {
    if (_currentPage < _totalPages) {
      _goToPage(_currentPage + 1);
    }
  }

  void _handleSecurityDismiss() {
    setState(() {
      _isScreenRecordingDetected = false;
    });
  }

  void _shareProgress() {
    // Share progress logic
    print('Sharing reading progress...');
  }

  void _downloadDocument() {
    // Download logic
    print('Downloading document for offline access...');
  }

  void _showReadingSettings() {
    // Show reading settings
    print('Opening reading settings...');
  }

  String _getPageTitle() {
    final toc = _tableOfContents
        .where((item) => (item["page"] as int) <= _currentPage)
        .toList();
    return toc.isNotEmpty ? toc.last["title"] as String : "Introduction";
  }
}
