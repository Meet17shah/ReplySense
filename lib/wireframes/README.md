# ReplySense App Wireframes

## Overview
This folder contains **low-fidelity wireframes** for the ReplySense application. These wireframes are designed to be used with design tools like **Stitch AI** or **Figma AI** for creating high-fidelity mockups.

## Color Scheme (Wireframe)
- **Primary**: Black (#000000)
- **Secondary**: White (#FFFFFF)  
- **Borders**: Gray (#BDBDBD)
- **Background**: Light Gray (#F5F5F5)
- **Text**: Dark Gray (#424242)

**No gradients, shadows, or colors - pure structure only!**

## Files Included

### 1. `wireframe_main.dart`
Main entry point for the wireframe app with navigation between screens.

### 2. `wireframe_components.dart`
Reusable wireframe components:
- `WireBox` - Simple boxes with labels
- `WireButton` - Basic button representation
- `WireTextField` - Input field placeholder
- `WireCard` - Card container
- `WireIcon` - Icon placeholder
- `WireText` - Text with different styles

### 3. `wireframe_screens.dart`
All screen wireframes:
- **Login Screen** - Email/password fields, Google sign-in
- **Dashboard** - Stats grid, activity list, welcome banner
- **Smart Replies** - Email summary, suggested replies (3 cards)
- **Templates** - List view with search, category filters
- **Profile** - User info, stats, settings options

## How to Run

```bash
# Navigate to project directory
cd replysense_app

# Run the wireframe app
flutter run lib/wireframes/wireframe_main.dart
```

## For Stitch AI / Figma AI

### Using with Stitch AI:
1. Take screenshots of each wireframe screen
2. Upload to Stitch AI
3. Prompt: "Convert this wireframe to high-fidelity UI with modern blue theme"

### Using with Figma AI:
1. Import the wireframe code structure
2. Use as reference for layout and spacing
3. Apply your design system on top

## Screen Specifications

### Login Screen
- Logo/Icon (circular, 100px)
- App name heading
- 2 text fields (Email, Password)
- Primary login button
- Google sign-in option
- Register link

### Dashboard
- Welcome banner (full width, gray background)
- 2x2 grid of stat cards
- Recent activity list (3-4 items)
- Bottom navigation

### Smart Replies
- Email summary card with icon
- Tone indicator chip
- 3 reply cards with copy button
- Save to history button

### Templates
- Search bar with add button
- Horizontal category filters
- Vertical list of template cards
- Each card: title, category tag, preview

### Profile
- Circular avatar (100px)
- User name and email chip
- 2 stat cards (Total Replies, This Week)
- Settings list (5 items)
- Logout button

## Design Notes

✅ **Structure First**: Focus on layout, spacing, hierarchy
✅ **Grayscale Only**: Black, white, grays - no colors
✅ **Simple Shapes**: Rectangles, circles, basic borders
✅ **Placeholder Content**: Generic text for understanding
✅ **No Styling**: No shadows, gradients, or effects
✅ **Clear Labels**: Everything labeled for clarity

## Converting to Final Design

When creating the actual design:
1. Replace gray boxes with actual icons
2. Add your color scheme (blues, cyans from main app)
3. Add shadows and elevation
4. Use real content and images
5. Apply Material Design 3 principles
6. Add transitions and animations

## Navigation Flow

```
Login Screen
    ↓
Dashboard (Home) ←→ Bottom Nav
    ↓                    ↓
Smart Replies    Templates    Profile
```

## Measurements Reference

- **Padding**: 16-24px
- **Button Height**: 48px
- **Card Border**: 2px
- **Border Radius**: 8-12px
- **Icon Size**: 40-48px (small), 100px (large)
- **Text Sizes**: 
  - Heading: 20px
  - Body: 14px
  - Small: 12px

---

**Created for**: ReplySense AI Email Assistant
**Purpose**: Design reference and AI tool input
**Format**: Flutter widgets (portable to any design tool)
**Status**: Ready for Stitch AI / Figma AI conversion
