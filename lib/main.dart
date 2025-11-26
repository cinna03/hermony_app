import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // <- add this


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables from .env
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: dotenv.env['FIREBASE_API_KEY']!,
      authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN'],
      projectId: dotenv.env['FIREBASE_PROJECT_ID'],
      storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'],
      messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID'],
      appId: dotenv.env['FIREBASE_APP_ID'],
    ),
  );

  runApp(const MyApp());
}
