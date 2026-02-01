# Quick Firebase Setup (No CLI Required!)

## Follow These Simple Steps:

### Step 1: Create Firebase Project (Web Browser)

1. Go to **https://console.firebase.google.com/**
2. Click **"Add project"** or **"Create a project"**
3. Enter project name: **replysense**
4. Accept terms and click **Continue**
5. Disable Google Analytics (optional) → **Create project**
6. Wait for project to be created → Click **Continue**

---

### Step 2: Enable Email/Password Authentication

1. In the Firebase Console, click **Authentication** in the left menu
2. Click **Get Started**
3. Go to **Sign-in method** tab
4. Click on **Email/Password**
5. Toggle **Enable** → Click **Save**

---

### Step 3: Register Your Android App

1. In Firebase Console, click the **Settings gear icon** → **Project settings**
2. Scroll down to **"Your apps"** section
3. Click the **Android icon** to add Android app
4. **Android package name**: Enter `com.example.replysense_app`
   - (You can find this in `android/app/build.gradle.kts`)
5. **App nickname**: `ReplySense Android` (optional)
6. Click **Register app**
7. **Download** the `google-services.json` file
8. **Place it** in: `android/app/google-services.json`

---

### Step 4: Configure Android Build Files

#### A. Edit `android/build.gradle.kts` (project-level):

Add this inside the `dependencies` block:

```kotlin
dependencies {
    classpath("com.android.tools.build:gradle:8.14.0")
    classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.0")
    classpath("com.google.gms:google-services:4.4.2")  // ← ADD THIS LINE
}
```

#### B. Edit `android/app/build.gradle.kts`:

Add at the **TOP** with other plugins:

```kotlin
plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")  // ← ADD THIS LINE
}
```

---

### Step 5: Update Firebase Options

Replace the content of `lib/firebase_options.dart` with your actual Firebase config:

**Get your config from Firebase Console:**
1. Go to Project Settings → General → Your apps → Android app
2. Scroll down and copy the values

**OR** use test values for now (update later):

The file is already created at `lib/firebase_options.dart`. You'll need to update it with real values later from Firebase Console.

---

### Step 6: Test the App

```bash
flutter pub get
flutter run
```

---

## What Should Work Now:

✅ **Registration**: Create a new account with email/password
✅ **Login**: Sign in with registered credentials  
✅ **Session**: App remembers you after closing
✅ **Logout**: Sign out and clear session
✅ **Profile**: Shows your name and email

---

## Testing Steps:

1. **Open the app** → Should show Login screen
2. **Click "Create Account"**
3. **Fill in:**
   - Full Name: `Test User`
   - Email: `test@example.com`
   - Password: `password123`
   - Confirm Password: `password123`
4. **Click "Create Account"** → Should show success dialog
5. **Click "Login Now"** → Enter email and password
6. **Click "Login"** → Should go to Home screen
7. **Close and reopen app** → Should auto-login to Home
8. **Go to Profile** → Click Logout → Should return to Login

---

## Common Issues:

**Issue**: "google-services.json not found"
- **Fix**: Make sure you placed it in `android/app/google-services.json`

**Issue**: Build errors after adding google-services plugin
- **Fix**: Run `cd android && ./gradlew clean` then `flutter clean && flutter pub get`

**Issue**: Firebase initialization error
- **Fix**: Update `firebase_options.dart` with real values from Firebase Console

---

## For Windows/Web Testing:

If you want to test on Windows or Web, you'll need to:
1. Add a Windows/Web app in Firebase Console  
2. Get the config values
3. Update `firebase_options.dart` accordingly

---

## Google Sign-In Setup (Optional):

If you want Google Sign-In to work:

1. In Firebase Console → **Authentication** → **Sign-in method**
2. Enable **Google** provider
3. For Android: You need SHA-1 fingerprint
   ```bash
   cd android
   ./gradlew signingReport
   ```
4. Copy the SHA-1 hash
5. Add it in Firebase Console → Project Settings → Your apps → Android app

---

## You're All Set! 🎉

Just complete Step 1-4 above and run the app. No Firebase CLI needed!

The authentication system is fully functional and ready to use.
