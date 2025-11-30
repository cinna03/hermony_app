# Firebase Setup Guide for HERmony App

## Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project"
3. Name it "hermony-app" (or your preferred name)
4. Enable Google Analytics (optional)
5. Create project

## Step 2: Enable Authentication

1. In Firebase Console, go to "Authentication"
2. Click "Get started"
3. Go to "Sign-in method" tab
4. Enable "Email/Password"
5. Enable "Google" (add your domain to authorized domains)

## Step 3: Create Firestore Database

1. Go to "Firestore Database"
2. Click "Create database"
3. Choose "Start in test mode" (for now)
4. Select your preferred location
5. Create database

## Step 4: Add Web App

1. In Project Overview, click the web icon (</>)
2. Register app with nickname "hermony-web"
3. Copy the Firebase configuration object
4. Replace the demo config in `lib/firebase_options.dart`

## Step 5: Update firebase_options.dart

Replace the demo configuration with your real Firebase config:

```dart
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'YOUR_ACTUAL_API_KEY',
  appId: 'YOUR_ACTUAL_APP_ID', 
  messagingSenderId: 'YOUR_ACTUAL_SENDER_ID',
  projectId: 'YOUR_ACTUAL_PROJECT_ID',
  authDomain: 'YOUR_PROJECT_ID.firebaseapp.com',
  storageBucket: 'YOUR_PROJECT_ID.appspot.com',
);
```

## Step 6: Deploy Security Rules

Copy the rules from `firestore.rules` to your Firestore Rules tab in Firebase Console.

## Step 7: Test Authentication

1. Run the app: `flutter run -d chrome`
2. Try signing up with a real email
3. Check your email for verification link
4. Try signing in after verification

## Troubleshooting

- If Google Sign-In fails, add your domain to authorized domains in Firebase Console
- If email verification doesn't work, check your Firebase project settings
- Make sure your Firebase project has billing enabled for production use