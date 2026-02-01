# Firebase Authentication Setup Guide

## Firebase Authentication Implementation Complete! 🎉

All authentication features have been implemented. Now you need to configure your Firebase project.

## What's Implemented:

✅ Login Screen with Email/Password
✅ Registration Screen with validation
✅ Google Sign-In integration
✅ Logout functionality
✅ Session management (auto-login)
✅ Error handling and validation
✅ User profile display with Firebase data

## Firebase Setup Steps:

### Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Enter project name: `ReplySense` (or your choice)
4. Follow the setup wizard

### Step 2: Enable Authentication

1. In Firebase Console, go to **Authentication**
2. Click **Get Started**
3. Go to **Sign-in method** tab
4. Enable **Email/Password**
5. Enable **Google** (optional, for Google Sign-In)

### Step 3: Add Android App

1. In Project Settings, click **Add app** → **Android**
2. Package name: `com.example.replysense_app` (check in `android/app/build.gradle.kts`)
3. Download `google-services.json`
4. Place it in: `android/app/google-services.json`

### Step 4: Configure Android

Add to `android/build.gradle.kts` (project level):
```kotlin
buildscript {
    dependencies {
        classpath("com.google.gms:google-services:4.4.2")
    }
}
```

Add to `android/app/build.gradle.kts`:
```kotlin
plugins {
    id("com.google.gms.google-services")
}
```

### Step 5: Run FlutterFire CLI (IMPORTANT!)

This will auto-generate the correct Firebase configuration:

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase (run in project root)
flutterfire configure
```

This will:
- Update `lib/firebase_options.dart` with your actual Firebase credentials
- Configure all platforms automatically

### Step 6: Install Dependencies

```bash
flutter pub get
```

### Step 7: Run the App

```bash
flutter run
```

## Features Available:

### 1. **Login Screen**
- Email/Password login
- Google Sign-In
- Validation
- Error messages
- "Create Account" link

### 2. **Registration Screen**
- Full Name field
- Email validation
- Password (min 6 characters)
- Confirm Password
- Error handling

### 3. **Session Management**
- Auto-login on app restart
- Persistent session with SharedPreferences
- Auth state checking

### 4. **Logout**
- Clears Firebase session
- Clears local session
- Redirects to login

### 5. **Profile Screen**
- Displays user's real name
- Displays user's email
- Logout button

## Testing the Authentication:

1. **Register a new user:**
   - Open app → Click "Create Account"
   - Fill in name, email, password
   - Click "Create Account"
   - Should show success dialog

2. **Login:**
   - Enter registered email and password
   - Click "Login"
   - Should navigate to Home screen

3. **Auto-login:**
   - Close and reopen the app
   - Should automatically go to Home (if logged in)

4. **Logout:**
   - Go to Profile screen
   - Click "Logout"
   - Confirm logout
   - Should redirect to Login screen

5. **Google Sign-In (if enabled):**
   - Click "Sign in with Google"
   - Select Google account
   - Should navigate to Home

## Error Handling:

The app handles these errors:
- Invalid email format
- Weak password (< 6 characters)
- Email already in use
- User not found
- Wrong password
- Network issues
- Too many failed attempts

## Files Modified:

- `lib/services/auth_service.dart` - Authentication logic
- `lib/screens/auth/login_screen.dart` - Login UI & logic
- `lib/screens/auth/register_screen.dart` - Registration UI & logic
- `lib/screens/profile/profile_screen.dart` - Logout & user display
- `lib/screens/splash/splash_screen.dart` - Session checking
- `lib/main.dart` - Firebase initialization
- `lib/firebase_options.dart` - Firebase config (needs FlutterFire CLI)
- `pubspec.yaml` - Dependencies added

## Next Steps After Firebase Setup:

1. Run `flutterfire configure`
2. Test registration
3. Test login
4. Test logout
5. Test session persistence
6. (Optional) Configure Google Sign-In in Firebase Console

## Important Notes:

⚠️ **The app won't work until you:**
1. Create Firebase project
2. Run `flutterfire configure`
3. Add `google-services.json` for Android
4. Enable Email/Password authentication in Firebase Console

🔐 **Security:**
- Never commit `google-services.json` to public repos
- Use environment variables for production
- Enable app check in Firebase for production apps

## For Google Sign-In Setup:

1. In Firebase Console → Authentication → Sign-in method
2. Enable Google provider
3. For Android: Add SHA-1 fingerprint
   ```bash
   cd android
   ./gradlew signingReport
   ```
4. Copy SHA-1 and add to Firebase project settings

---

Your authentication system is ready! Just configure Firebase and test! 🚀
