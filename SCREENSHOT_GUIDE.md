# 📸 Screenshot Capture Guide

## Required Screenshots for Submission

---

## 1️⃣ Login Screen (MANDATORY)

### How to Capture:
1. Run: `flutter run -d chrome`
2. Wait for app to load
3. You'll see the login screen automatically
4. Capture full browser window

### What Should Be Visible:
- ✅ Blue circular logo with chat icon
- ✅ "ReplySense" title
- ✅ "AI-Powered Reply Assistant" subtitle
- ✅ Email input field with icon
- ✅ Password input field with eye icon
- ✅ "Forgot Password?" link
- ✅ Blue "Login" button
- ✅ "Don't have an account? Create Account" at bottom

### File Name: `screenshot_1_login_screen.png`

---

## 2️⃣ Password Visibility Toggle (MANDATORY)

### How to Capture:
1. On login screen
2. Click the eye icon in password field
3. Take screenshot showing password visible
4. Click again to hide

### What Should Be Visible:
- ✅ Password field showing text (not dots)
- ✅ Eye icon with line through it (visibility_off)
- ✅ Or before/after comparison

### File Name: `screenshot_2_password_toggle.png`

---

## 3️⃣ Dashboard Screen (MANDATORY)

### How to Capture:
1. From login screen, enter any email (e.g., test@test.com)
2. Enter any password (e.g., 123456)
3. Click "Login" button
4. Dashboard appears
5. Capture full browser window

### What Should Be Visible:
- ✅ Blue app bar with "ReplySense" title
- ✅ Notification and profile icons
- ✅ Blue gradient welcome banner
- ✅ 4 feature cards:
  - Smart Replies (blue icon)
  - Email Analysis (purple icon)
  - Saved Templates (orange icon)
  - Conversations (green icon)
- ✅ "Recent Activity" section with 4 items
- ✅ Bottom navigation bar (4 tabs)
- ✅ Orange "New Reply" floating button

### File Name: `screenshot_3_dashboard.png`

---

## 4️⃣ Folder Structure (MANDATORY)

### How to Capture:
1. Open VS Code
2. Expand the `lib/` folder in Explorer
3. Expand subfolders:
   - config/
   - screens/auth/
   - screens/home/
   - widgets/
4. Capture the file tree view

### What Should Be Visible:
```
lib/
├── main.dart
├── config/
│   ├── constants.dart
│   └── theme.dart
├── screens/
│   ├── auth/
│   │   └── login_screen.dart
│   └── home/
│       └── home_screen.dart
├── widgets/
│   ├── custom_button.dart
│   ├── custom_card.dart
│   └── custom_text_field.dart
```

### File Name: `screenshot_4_folder_structure.png`

---

## 5️⃣ Reusable Components (OPTIONAL)

### Option A: Code View
1. Open `lib/widgets/custom_button.dart` in VS Code
2. Capture the code showing the class definition

### Option B: Component in Use
1. On login screen, capture the Login button
2. Show it's using CustomButton (can add comment in code)

### File Name: `screenshot_5_reusable_components.png`

---

## 6️⃣ Responsive Design Demo (OPTIONAL)

### How to Capture:
1. On dashboard, resize browser window to small (mobile size)
2. Take screenshot
3. Resize browser window to large (desktop size)
4. Take screenshot
5. Combine both screenshots side-by-side

### What Should Be Visible:
- ✅ Small screen: 2 columns of feature cards
- ✅ Large screen: 4 columns of feature cards
- ✅ Font sizes adapt
- ✅ Padding adjusts

### File Name: `screenshot_6_responsive.png`

---

## 📋 Screenshot Checklist

Before submitting, verify each screenshot shows:

### Screenshot 1: Login Screen
- [ ] Clear and in focus
- [ ] Full screen visible
- [ ] All UI elements visible
- [ ] No browser elements (address bar) if possible

### Screenshot 2: Password Toggle
- [ ] Eye icon visible
- [ ] Password field in focus
- [ ] Shows the toggle functionality

### Screenshot 3: Dashboard
- [ ] All 4 feature cards visible
- [ ] Welcome banner at top
- [ ] Recent activity list visible
- [ ] Bottom navigation visible
- [ ] Floating action button visible

### Screenshot 4: Folder Structure
- [ ] lib/ folder expanded
- [ ] All subfolders visible
- [ ] File names clearly readable

---

## 🎨 Screenshot Quality Tips

### Best Practices:
1. **Full Resolution** - Don't compress images
2. **Clean Background** - Close unnecessary browser tabs
3. **Proper Lighting** - If screen recording, ensure good visibility
4. **No Personal Info** - Don't show real email addresses
5. **Consistent Size** - Try to keep all screenshots similar dimensions

### Recommended Tools:

**Windows:**
- Windows + Shift + S (Snipping Tool)
- Alt + Print Screen (Active Window)
- Snagit (Professional)

**Mac:**
- Cmd + Shift + 4 (Selection)
- Cmd + Shift + 3 (Full Screen)

**Chrome Extension:**
- Full Page Screen Capture
- Awesome Screenshot

---

## 📐 Recommended Dimensions

### For Presentation:
- **Width:** 1200-1920px
- **Height:** Auto (maintain aspect ratio)
- **Format:** PNG (best quality)

### For Document Submission:
- **Width:** 1024px (resize if needed)
- **Format:** PNG or JPG
- **File Size:** < 2MB per image

---

## 📁 Organize Your Screenshots

### Create a Folder:
```
screenshots/
├── 1_login_screen.png
├── 2_password_toggle.png
├── 3_dashboard.png
├── 4_folder_structure.png
├── 5_reusable_components.png (optional)
└── 6_responsive.png (optional)
```

---

## ✂️ Editing Screenshots (Optional)

### Simple Edits:
1. **Crop** - Remove unnecessary browser chrome
2. **Annotate** - Add arrows pointing to key features
3. **Highlight** - Circle important elements
4. **Combine** - Create before/after comparisons

### Recommended Tools:
- **Snagit** - Professional screenshot editing
- **Paint 3D** - Basic editing (Windows)
- **Preview** - Basic editing (Mac)
- **GIMP** - Free advanced editing

### What to Highlight:
- App logo
- Form validation
- Password toggle icon
- Feature cards
- Navigation elements
- Reusable components

---

## 📧 Submission Format

### Include with Submission:
1. Screenshots folder (all images)
2. `UI_LAB_SUBMISSION.md` (documentation)
3. Code snippets (from documentation)
4. Optional: Brief video walkthrough (< 2 min)

### Email/Upload Format:
```
Subject: UI Lab Submission - MEET HIREN SHAH

Attachments:
- screenshots.zip
- UI_LAB_SUBMISSION.md
- QUICK_START.md

Body:
Brief description of implementation
Link to video demo (if applicable)
```

---

## 🎬 Optional: Video Walkthrough

### If Creating a Video (Recommended):
1. **Screen Record** - Use OBS Studio or QuickTime
2. **Duration** - Keep under 2 minutes
3. **Show:**
   - Login screen tour
   - Password toggle
   - Form validation
   - Dashboard features
   - Responsive resize
   - Code structure

### Script Outline:
```
0:00 - 0:15 : Login screen walkthrough
0:15 - 0:30 : Form validation demo
0:30 - 0:45 : Dashboard tour
0:45 - 1:00 : Feature cards and navigation
1:00 - 1:15 : Responsive design demo
1:15 - 1:30 : Folder structure and code
1:30 - 2:00 : Reusable components explanation
```

---

## ✅ Final Checklist

Before submitting:
- [ ] All 4 mandatory screenshots captured
- [ ] Images are clear and in focus
- [ ] File names follow convention
- [ ] Images are organized in a folder
- [ ] Screenshots match documentation
- [ ] No sensitive information visible
- [ ] File sizes are reasonable (< 2MB each)
- [ ] Verified all UI elements visible
- [ ] Ready to submit!

---

**You're Ready to Capture! 📸**

Run `flutter run -d chrome` and start capturing your screenshots!
