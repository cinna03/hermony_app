@echo off
echo Setting up Firebase for HERmony App...
echo.

echo Step 1: Install Firebase CLI
npm install -g firebase-tools

echo.
echo Step 2: Login to Firebase
firebase login

echo.
echo Step 3: Initialize Firebase in project
firebase init

echo.
echo Step 4: Configure FlutterFire
dart pub global activate flutterfire_cli
flutterfire configure

echo.
echo Firebase setup complete!
echo Remember to update your Firebase config in lib/firebase_options.dart
pause