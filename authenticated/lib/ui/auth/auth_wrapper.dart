import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../welcome_screen.dart';
import '../dashboard/dashboard_screen.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        // Show loading while checking auth state
        if (authProvider.isLoading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        
        // Navigate based on authentication state
        if (authProvider.isAuthenticated) {
          return DashboardScreen();
        } else {
          return WelcomeScreen();
        }
      },
    );
  }
}