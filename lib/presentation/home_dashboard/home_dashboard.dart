import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/preparation_meter_card.dart';
import './widgets/quick_access_grid.dart';
import './widgets/recent_activity_section.dart';
import './widgets/sticky_header_widget.dart';
import './widgets/todays_schedule_widget.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({Key? key}) : super(key: key);

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  String _selectedBatch = "IIT JEE 2025 - Allen Kota";
  int _notificationCount = 5;
  bool _isRefreshing = false;
  late AnimationController _fabAnimationController;
  late Animation<double> _fabAnimation;

  final List<Map<String, dynamic>> _batches = [
    {"id": 1, "name": "IIT JEE 2025 - Allen Kota", "type": "IIT JEE"},
    {"id": 2, "name": "NEET 2025 - Aakash Delhi", "type": "NEET"},
    {"id": 3, "name": "UPSC 2025 - Vajiram Chennai", "type": "UPSC"},
  ];

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fabAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fabAnimationController, curve: Curves.easeInOut),
    );
    _fabAnimationController.forward();
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate refresh delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isRefreshing = false;
    });
  }

  void _handleQuickAccessTap(String cardId) {
    switch (cardId) {
      case 'my_batches':
        // Navigate to batches screen
        Navigator.pushNamed(context, '/study-materials-screen');
        break;
      case 'battleground':
        Navigator.pushNamed(context, '/quiz-screen');
        break;
      case 'my_doubts':
        // Navigate to doubts screen
        Navigator.pushNamed(context, '/study-materials-screen');
        break;
      case 'my_history':
        // Navigate to history screen
        Navigator.pushNamed(context, '/profile-screen');
        break;
      case 'downloads':
        // Navigate to downloads screen
        Navigator.pushNamed(context, '/study-materials-screen');
        break;
      case 'bookmarks':
        // Navigate to bookmarks screen
        Navigator.pushNamed(context, '/pdf-viewer-screen');
        break;
    }
  }

  void _showBatchSelector() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Batch',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: 2.h),
            ..._batches
                .map((batch) => ListTile(
                      leading: CustomIconWidget(
                        iconName: 'school',
                        color: batch["name"] == _selectedBatch
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                        size: 24,
                      ),
                      title: Text(
                        batch["name"] as String,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: batch["name"] == _selectedBatch
                                      ? Theme.of(context).primaryColor
                                      : null,
                                  fontWeight: batch["name"] == _selectedBatch
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                      ),
                      subtitle: Text(
                        batch["type"] as String,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing: batch["name"] == _selectedBatch
                          ? CustomIconWidget(
                              iconName: 'check_circle',
                              color: Theme.of(context).primaryColor,
                              size: 20,
                            )
                          : null,
                      onTap: () {
                        setState(() {
                          _selectedBatch = batch["name"] as String;
                        });
                        Navigator.pop(context);
                      },
                    ))
                .toList(),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  void _handleNotificationTap() {
    // Navigate to notifications screen or show notifications
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notifications feature coming soon!'),
      ),
    );
  }

  void _handleThemeToggle() {
    // Toggle theme implementation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Dark theme toggle coming soon!'),
      ),
    );
  }

  void _handleDoubtSubmission() {
    // Navigate to doubt submission screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Doubt submission feature coming soon!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          StickyHeaderWidget(
            selectedBatch: _selectedBatch,
            notificationCount: _notificationCount,
            onBatchTap: _showBatchSelector,
            onThemeToggle: _handleThemeToggle,
            onNotificationTap: _handleNotificationTap,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _handleRefresh,
              color: Theme.of(context).primaryColor,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_isRefreshing)
                      Container(
                        padding: EdgeInsets.all(2.h),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                'Refreshing dashboard...',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    PreparationMeterCard(
                      progressPercentage: 73.5,
                      xpPoints: 1247,
                      comparisonText:
                          "You're ahead of 68% of students in your batch",
                    ),
                    QuickAccessGrid(
                      onCardTap: _handleQuickAccessTap,
                    ),
                    RecentActivitySection(),
                    TodaysScheduleWidget(),
                    SizedBox(height: 10.h), // Bottom padding for FAB
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          switch (index) {
            case 0:
              // Already on home
              break;
            case 1:
              // Navigate to batches
              Navigator.pushNamed(context, '/study-materials-screen');
              break;
            case 2:
              Navigator.pushNamed(context, '/profile-screen');
              break;
            case 3:
              // Navigate to store
              Navigator.pushNamed(context, '/study-materials-screen');
              break;
            case 4:
              Navigator.pushNamed(context, '/profile-screen');
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
        selectedLabelStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
        unselectedLabelStyle: Theme.of(context).textTheme.labelSmall,
        elevation: 8,
        items: [
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'home',
              color: _currentIndex == 0
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              size: 24,
            ),
            label: 'Study',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'groups',
              color: _currentIndex == 1
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              size: 24,
            ),
            label: 'Batches',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'quiz',
              color: _currentIndex == 2
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              size: 24,
            ),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'store',
              color: _currentIndex == 3
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              size: 24,
            ),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'person',
              color: _currentIndex == 4
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              size: 24,
            ),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: ScaleTransition(
        scale: _fabAnimation,
        child: FloatingActionButton.extended(
          onPressed: _handleDoubtSubmission,
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          elevation: 4,
          icon: CustomIconWidget(
            iconName: 'help_outline',
            color: Colors.white,
            size: 20,
          ),
          label: Text(
            'Ask Doubt',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
