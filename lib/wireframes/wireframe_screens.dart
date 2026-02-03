import 'package:flutter/material.dart';
import 'wireframe_components.dart';

/// LOGIN SCREEN WIREFRAME
class WireframeLogin extends StatelessWidget {
  const WireframeLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          
          // App Logo/Icon
          const WireIcon(icon: Icons.reply, size: 100, isCircle: true),
          const SizedBox(height: 24),
          
          // App Name
          const WireText(text: 'ReplySense', isHeading: true),
          const SizedBox(height: 8),
          const WireText(text: 'AI-Powered Email Assistant'),
          const SizedBox(height: 60),
          
          // Email Field
          const WireTextField(
            placeholder: 'Email',
            icon: Icons.email,
          ),
          const SizedBox(height: 16),
          
          // Password Field
          const WireTextField(
            placeholder: 'Password',
            icon: Icons.lock,
          ),
          const SizedBox(height: 24),
          
          // Login Button
          const WireButton(label: 'Login', isPrimary: true),
          const SizedBox(height: 16),
          
          // Google Sign In
          WireCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WireBox(width: 24, height: 24, label: 'G'),
                const SizedBox(width: 12),
                const WireText(text: 'Sign in with Google', isBold: true),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Register Link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const WireText(text: 'Don\'t have an account?'),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: const WireText(text: 'Register', isBold: true),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// DASHBOARD SCREEN WIREFRAME
class WireframeDashboard extends StatelessWidget {
  const WireframeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF2563EB).withOpacity(0.1),
                  const Color(0xFF3B82F6).withOpacity(0.05),
                ],
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WireText(text: 'Welcome Back!', isHeading: true),
                SizedBox(height: 8),
                WireText(text: 'Manage your templates and smart responses'),
              ],
            ),
          ),
          
          const Padding(
            padding: EdgeInsets.all(16),
            child: WireText(text: 'Overview', isHeading: true),
          ),
          
          // Stats Grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.9,
              children: [
                _buildStatBox('Smart Replies', '24', Icons.auto_awesome),
                _buildStatBox('Email Analysis', '12', Icons.analytics),
                _buildStatBox('Saved Templates', '8', Icons.description),
                _buildStatBox('Conversations', '156', Icons.chat),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.all(16),
            child: WireText(text: 'Recent Activity', isHeading: true),
          ),
          
          // Activity List
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildActivityItem('New template created', 'Professional Thank You'),
                _buildActivityItem('Smart reply generated', 'Meeting request'),
                _buildActivityItem('Email analyzed', 'Customer inquiry'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox(String title, String count, IconData icon) {
    return WireCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF2563EB).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF2563EB), size: 32),
          ),
          const SizedBox(height: 12),
          WireText(text: count, isHeading: true),
          const SizedBox(height: 4),
          WireText(text: title),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String title, String subtitle) {
    return WireCard(
      child: Row(
        children: [
          const WireIcon(icon: Icons.circle, size: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WireText(text: title, isBold: true),
                const SizedBox(height: 4),
                WireText(text: subtitle),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}

/// SMART REPLIES SCREEN WIREFRAME
class WireframeSmartReplies extends StatelessWidget {
  const WireframeSmartReplies({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WireText(text: 'Email Summary', isHeading: true),
          const SizedBox(height: 16),
          
          // Summary Box
          WireCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2563EB).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.summarize, color: Color(0xFF2563EB), size: 24),
                    ),
                    const SizedBox(width: 12),
                    const WireText(text: 'Summary', isBold: true),
                  ],
                ),
                const SizedBox(height: 12),
                WireBox(
                  height: 80,
                  label: 'Email summary content appears here...',
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          Row(
            children: [
              const WireText(text: 'Suggested Replies', isHeading: true),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const WireText(text: 'Tone: Professional'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Reply Cards
          _buildReplyCard('Reply 1'),
          const SizedBox(height: 16),
          _buildReplyCard('Reply 2'),
          const SizedBox(height: 16),
          _buildReplyCard('Reply 3'),
          
          const SizedBox(height: 24),
          const WireButton(label: 'Save to History', isPrimary: true),
        ],
      ),
    );
  }

  Widget _buildReplyCard(String label) {
    return WireCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  label,
                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              const Icon(Icons.copy, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 12),
          WireBox(
            height: 100,
            label: 'Generated reply text appears here...\nMultiple lines of response.',
          ),
        ],
      ),
    );
  }
}

/// TEMPLATES SCREEN WIREFRAME
class WireframeTemplates extends StatelessWidget {
  const WireframeTemplates({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: WireTextField(
                  placeholder: 'Search templates...',
                  icon: Icons.search,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
        ),
        
        // Category Filter
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildCategoryChip('All', isSelected: true),
              _buildCategoryChip('Professional'),
              _buildCategoryChip('Casual'),
              _buildCategoryChip('Thank You'),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Template List
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildTemplateCard('Professional Thank You', 'Professional'),
              _buildTemplateCard('Meeting Follow-up', 'Professional'),
              _buildTemplateCard('Quick Reply', 'Casual'),
              _buildTemplateCard('Introduction', 'Professional'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(String label, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF2563EB) : Colors.white,
        border: Border.all(
          color: isSelected ? const Color(0xFF2563EB) : Colors.grey,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Colors.white : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTemplateCard(String title, String category) {
    return WireCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: WireText(text: title, isBold: true)),
              const Icon(Icons.more_vert, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: WireText(text: category),
          ),
          const SizedBox(height: 12),
          WireBox(height: 60, label: 'Template content preview...'),
        ],
      ),
    );
  }
}

/// PROFILE SCREEN WIREFRAME
class WireframeProfile extends StatelessWidget {
  const WireframeProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 24),
          
          // Profile Avatar
          const WireIcon(icon: Icons.person, size: 100, isCircle: true),
          const SizedBox(height: 16),
          
          // User Name
          const WireText(text: 'Meet Shah', isHeading: true),
          const SizedBox(height: 8),
          
          // Email Chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.email, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                const WireText(text: 'meetshah@example.com'),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Stats Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(child: _buildStatBox('Total Replies', '24')),
                const SizedBox(width: 12),
                Expanded(child: _buildStatBox('This Week', '8')),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Settings Options
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildSettingsTile('Edit Profile', 'Update your information'),
                _buildSettingsTile('Notifications', 'Manage notifications'),
                _buildSettingsTile('Language', 'English'),
                _buildSettingsTile('Privacy', 'Manage privacy settings'),
                _buildSettingsTile('Help', 'Get help and support'),
                const SizedBox(height: 16),
                const WireButton(label: 'Logout', isPrimary: false),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildStatBox(String title, String value) {
    return WireCard(
      child: Column(
        children: [
          const WireIcon(icon: Icons.bar_chart, size: 40),
          const SizedBox(height: 8),
          WireText(text: value, isHeading: true),
          const SizedBox(height: 4),
          WireText(text: title),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(String title, String subtitle) {
    return WireCard(
      child: Row(
        children: [
          const WireIcon(icon: Icons.circle, size: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WireText(text: title, isBold: true),
                const SizedBox(height: 4),
                WireText(text: subtitle),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}
