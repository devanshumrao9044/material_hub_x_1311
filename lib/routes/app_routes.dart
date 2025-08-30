import 'package:flutter/material.dart';
import '../presentation/study_materials_screen/study_materials_screen.dart';
import '../presentation/pdf_viewer_screen/pdf_viewer_screen.dart';
import '../presentation/home_dashboard/home_dashboard.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/profile_screen/profile_screen.dart';
import '../presentation/batch_selection_screen/batch_selection_screen.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String studyMaterials = '/study-materials-screen';
  static const String pdfViewer = '/pdf-viewer-screen';
  static const String homeDashboard = '/home-dashboard';
  static const String login = '/login-screen';
  static const String profile = '/profile-screen';
  static const String batchSelection = '/batch-selection-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const LoginScreen(),
    studyMaterials: (context) => const StudyMaterialsScreen(),
    pdfViewer: (context) => const PdfViewerScreen(),
    homeDashboard: (context) => const HomeDashboard(),
    login: (context) => const LoginScreen(),
    profile: (context) => const ProfileScreen(),
    batchSelection: (context) => const BatchSelectionScreen(),
    import 'package:material_hub_x_1311/presentation/contact_us/contact_us_page.dart';
    // TODO: Add your other routes here
  };
}
