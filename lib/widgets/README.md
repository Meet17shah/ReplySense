# Reusable Widgets Documentation

This folder contains reusable UI components for the ReplySense application.

---

## 📦 Available Components

### 1. CustomButton
**File:** `custom_button.dart`

A versatile button component with support for different styles and states.

#### Features:
- ✅ Elevated and outlined variants
- ✅ Loading state with spinner
- ✅ Optional icon support
- ✅ Customizable colors and dimensions
- ✅ Consistent border radius (12px)

#### Usage:
```dart
// Basic elevated button
CustomButton(
  text: 'Login',
  onPressed: () {
    // Handle press
  },
)

// Button with icon
CustomButton(
  text: 'Save',
  icon: Icons.save,
  onPressed: () {},
)

// Outlined button
CustomButton(
  text: 'Cancel',
  onPressed: () {},
  isOutlined: true,
)

// Loading state
CustomButton(
  text: 'Processing...',
  onPressed: () {},
  isLoading: true,
)

// Custom colors
CustomButton(
  text: 'Delete',
  onPressed: () {},
  backgroundColor: Colors.red,
  textColor: Colors.white,
)

// Full width button
CustomButton(
  text: 'Continue',
  onPressed: () {},
  width: double.infinity,
)
```

#### Parameters:
- `text` (String, required): Button label
- `onPressed` (VoidCallback, required): Click handler
- `backgroundColor` (Color?, optional): Background color (defaults to primary)
- `textColor` (Color?, optional): Text color (defaults to white)
- `icon` (IconData?, optional): Icon to display before text
- `isLoading` (bool, default: false): Show loading spinner
- `isOutlined` (bool, default: false): Use outlined style
- `width` (double?, optional): Button width
- `height` (double, default: 50): Button height

---

### 2. CustomTextField
**File:** `custom_text_field.dart`

A text input component with consistent styling and validation support.

#### Features:
- ✅ Consistent styling across the app
- ✅ Support for prefix and suffix icons
- ✅ Built-in validation
- ✅ Obscure text option for passwords
- ✅ Multiple line support
- ✅ Enabled/disabled states

#### Usage:
```dart
// Basic text field
CustomTextField(
  controller: _nameController,
  labelText: 'Name',
  hintText: 'Enter your name',
)

// Email field with icon
CustomTextField(
  controller: _emailController,
  labelText: 'Email',
  hintText: 'Enter your email',
  prefixIcon: Icons.email_outlined,
  keyboardType: TextInputType.emailAddress,
)

// Password field
CustomTextField(
  controller: _passwordController,
  labelText: 'Password',
  hintText: 'Enter password',
  prefixIcon: Icons.lock_outline,
  obscureText: true,
)

// Text field with validation
CustomTextField(
  controller: _emailController,
  labelText: 'Email',
  hintText: 'Enter your email',
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  },
)

// Multi-line text field
CustomTextField(
  controller: _descriptionController,
  labelText: 'Description',
  hintText: 'Enter description',
  maxLines: 5,
)

// Disabled field
CustomTextField(
  controller: _readOnlyController,
  labelText: 'Read Only',
  hintText: 'Cannot edit',
  enabled: false,
)
```

#### Parameters:
- `controller` (TextEditingController, required): Text controller
- `labelText` (String, required): Field label
- `hintText` (String, required): Placeholder text
- `prefixIcon` (IconData?, optional): Icon at the start
- `suffixIcon` (Widget?, optional): Widget at the end (e.g., visibility toggle)
- `obscureText` (bool, default: false): Hide text (for passwords)
- `keyboardType` (TextInputType, default: text): Keyboard type
- `validator` (Function?, optional): Validation function
- `maxLines` (int, default: 1): Number of lines
- `enabled` (bool, default: true): Enable/disable input

---

### 3. CustomCard
**File:** `custom_card.dart`

A collection of card components for displaying content.

#### Variants:

#### 3.1 CustomCard (Basic)
Basic card with optional tap support.

```dart
// Simple card
CustomCard(
  child: Text('Card Content'),
)

// Card with tap
CustomCard(
  onTap: () {
    print('Card tapped');
  },
  child: Column(
    children: [
      Text('Title'),
      Text('Description'),
    ],
  ),
)

// Custom styling
CustomCard(
  padding: EdgeInsets.all(20),
  elevation: 4,
  color: Colors.blue[50],
  borderRadius: BorderRadius.circular(16),
  child: Text('Custom Card'),
)
```

**Parameters:**
- `child` (Widget, required): Card content
- `padding` (EdgeInsetsGeometry?, default: 16px all): Internal padding
- `color` (Color?, default: white): Background color
- `elevation` (double?, default: 2): Shadow elevation
- `onTap` (VoidCallback?, optional): Tap handler
- `borderRadius` (BorderRadius?, default: 12px): Corner radius

---

#### 3.2 FeatureCard
Card designed for displaying features with icons.

```dart
FeatureCard(
  title: 'Smart Replies',
  subtitle: 'AI-generated responses',
  icon: Icons.auto_awesome,
  iconColor: Colors.blue,
  onTap: () {
    // Navigate to feature
  },
)
```

**Parameters:**
- `title` (String, required): Feature title
- `subtitle` (String, required): Feature description
- `icon` (IconData, required): Feature icon
- `iconColor` (Color, required): Icon color
- `onTap` (VoidCallback, required): Tap handler

---

#### 3.3 InfoCard
Card for displaying information with icon and value.

```dart
InfoCard(
  title: 'Total Users',
  value: '1,234',
  icon: Icons.people,
  color: Colors.blue,
)
```

**Parameters:**
- `title` (String, required): Info label
- `value` (String, required): Info value
- `icon` (IconData, required): Icon
- `color` (Color, required): Theme color

---

## 🎨 Design System

All widgets follow the app's design system defined in `lib/config/theme.dart`:

### Colors
- **Primary:** #2196F3 (Blue)
- **Accent:** #FF9800 (Orange)
- **Success:** #4CAF50 (Green)
- **Error:** #F44336 (Red)

### Border Radius
- **Buttons/Inputs:** 12px
- **Cards:** 12-16px

### Elevation
- **Cards:** 2px
- **Buttons:** 2px

### Spacing
- **Small:** 8-12px
- **Medium:** 16px
- **Large:** 24px

---

## 📱 Responsive Behavior

All widgets adapt to different screen sizes:
- Font sizes adjust based on screen width
- Padding scales appropriately
- Icons maintain proper proportions

---

## 🔄 Best Practices

### 1. Always use controllers for TextFields
```dart
final _controller = TextEditingController();

@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
```

### 2. Provide meaningful labels and hints
```dart
CustomTextField(
  labelText: 'Email Address',  // Clear label
  hintText: 'user@example.com', // Example format
)
```

### 3. Add validation for user inputs
```dart
validator: (value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }
  return null;
}
```

### 4. Use semantic colors
```dart
CustomButton(
  text: 'Delete',
  backgroundColor: Theme.of(context).colorScheme.error,
)
```

---

## 📝 Examples

### Complete Login Form
```dart
Form(
  key: _formKey,
  child: Column(
    children: [
      CustomTextField(
        controller: _emailController,
        labelText: 'Email',
        hintText: 'Enter your email',
        prefixIcon: Icons.email_outlined,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email';
          }
          if (!value.contains('@')) {
            return 'Please enter a valid email';
          }
          return null;
        },
      ),
      SizedBox(height: 16),
      CustomTextField(
        controller: _passwordController,
        labelText: 'Password',
        hintText: 'Enter your password',
        prefixIcon: Icons.lock_outline,
        obscureText: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          if (value.length < 6) {
            return 'Password must be at least 6 characters';
          }
          return null;
        },
      ),
      SizedBox(height: 24),
      CustomButton(
        text: 'Login',
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Process login
          }
        },
        width: double.infinity,
      ),
    ],
  ),
)
```

### Dashboard Cards Grid
```dart
GridView.count(
  crossAxisCount: 2,
  crossAxisSpacing: 16,
  mainAxisSpacing: 16,
  children: [
    FeatureCard(
      title: 'Smart Replies',
      subtitle: 'AI responses',
      icon: Icons.auto_awesome,
      iconColor: Colors.blue,
      onTap: () {},
    ),
    FeatureCard(
      title: 'Analytics',
      subtitle: 'View insights',
      icon: Icons.bar_chart,
      iconColor: Colors.purple,
      onTap: () {},
    ),
  ],
)
```

---

## 🚀 Future Enhancements

Planned improvements for these components:
- [ ] Dark mode support
- [ ] Animation effects
- [ ] More button variants (text, icon-only)
- [ ] Dropdown field widget
- [ ] Date picker widget
- [ ] Checkbox and radio widgets

---

**Happy Coding! 🎨**
