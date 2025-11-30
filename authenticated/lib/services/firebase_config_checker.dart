import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseConfigChecker {
  static Future<Map<String, bool>> checkConfiguration() async {
    Map<String, bool> status = {
      'firebase_initialized': false,
      'auth_available': false,
      'firestore_available': false,
      'demo_config': false,
    };

    try {
      // Check if Firebase is initialized
      if (Firebase.apps.isNotEmpty) {
        status['firebase_initialized'] = true;
        
        // Check if using demo configuration
        final app = Firebase.app();
        if (app.options.projectId == 'demo-project' && 
            app.options.apiKey.contains('Demo')) {
          status['demo_config'] = true;
        }
      }

      // Check Firebase Auth
      try {
        FirebaseAuth.instance;
        status['auth_available'] = true;
      } catch (e) {
        print('Firebase Auth error: $e');
      }

      // Check Firestore
      try {
        FirebaseFirestore.instance;
        status['firestore_available'] = true;
      } catch (e) {
        print('Firestore error: $e');
      }

    } catch (e) {
      print('Firebase configuration error: $e');
    }

    return status;
  }

  static void printStatus(Map<String, bool> status) {
    print('=== Firebase Configuration Status ===');
    print('Firebase Initialized: ${status['firebase_initialized']}');
    print('Auth Available: ${status['auth_available']}');
    print('Firestore Available: ${status['firestore_available']}');
    print('Using Demo Config: ${status['demo_config']}');
    
    if (status['demo_config'] == true) {
      print('\n⚠️  WARNING: Using demo Firebase configuration!');
      print('Replace API keys in lib/firebase_options.dart with real values.');
    }
    
    if (status.values.every((v) => v == true)) {
      print('\n✅ Firebase is properly configured!');
    } else {
      print('\n❌ Firebase configuration issues detected.');
    }
  }
}