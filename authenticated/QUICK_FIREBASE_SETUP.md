# Quick Firebase Setup (5 minutes)

## Option 1: Automated Setup
```bash
# Run the setup script
setup_firebase.bat
```

## Option 2: Manual Setup

### 1. Create Firebase Project
- Go to https://console.firebase.google.com/
- Create project "hermony-app"
- Enable Authentication > Email/Password
- Create Firestore Database (test mode)

### 2. Get Web Config
- Project Settings > General > Your apps
- Add web app "hermony-web"
- Copy the config object

### 3. Update Config
Replace values in `lib/firebase_options.dart`:
```dart
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'YOUR_API_KEY_HERE',
  appId: 'YOUR_APP_ID_HERE', 
  messagingSenderId: 'YOUR_SENDER_ID_HERE',
  projectId: 'YOUR_PROJECT_ID_HERE',
  authDomain: 'YOUR_PROJECT_ID.firebaseapp.com',
  storageBucket: 'YOUR_PROJECT_ID.appspot.com',
);
```

### 4. Test
```bash
flutter run -d chrome
```

## Troubleshooting
- If Google Sign-In fails: Add your domain to Firebase Console > Authentication > Settings > Authorized domains
- If build fails: Run `flutter clean && flutter pub get`