import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../providers/theme_provider.dart';
import '../../providers/auth_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _locationEnabled = true;
  bool _offlineMode = false;
  String _selectedLanguage = 'English';
  String _selectedCurrency = 'KES';

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // User Info Section
          Container(
            color: AppColors.primary.withOpacity(0.1),
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: AppColors.primary,
                  child: Text(
                    authProvider.user?.name.substring(0, 1).toUpperCase() ?? 'U',
                    style: const TextStyle(fontSize: 28, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authProvider.user?.name ?? 'User',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        authProvider.user?.email ?? '',
                        style: TextStyle(color: AppColors.grey600),
                      ),
                      Text(
                        authProvider.user?.role.toUpperCase() ?? '',
                        style: TextStyle(color: AppColors.secondary, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Appearance Section
          _buildSectionHeader('Appearance'),
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Use dark theme'),
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme();
            },
            secondary: Icon(
              themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: AppColors.primary,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.language, color: AppColors.primary),
            title: const Text('Language'),
            subtitle: Text(_selectedLanguage),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showLanguageDialog(),
          ),

          const Divider(),

          // Preferences Section
          _buildSectionHeader('Preferences'),
          SwitchListTile(
            title: const Text('Notifications'),
            subtitle: const Text('Enable push notifications'),
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() => _notificationsEnabled = value);
            },
            secondary: const Icon(Icons.notifications, color: AppColors.primary),
          ),
          SwitchListTile(
            title: const Text('Location Services'),
            subtitle: const Text('Allow GPS tracking'),
            value: _locationEnabled,
            onChanged: (value) {
              setState(() => _locationEnabled = value);
            },
            secondary: const Icon(Icons.location_on, color: AppColors.primary),
          ),
          SwitchListTile(
            title: const Text('Offline Mode'),
            subtitle: const Text('Work without internet'),
            value: _offlineMode,
            onChanged: (value) {
              setState(() => _offlineMode = value);
            },
            secondary: const Icon(Icons.cloud_off, color: AppColors.primary),
          ),
          ListTile(
            leading: const Icon(Icons.attach_money, color: AppColors.primary),
            title: const Text('Currency'),
            subtitle: Text(_selectedCurrency),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showCurrencyDialog(),
          ),

          const Divider(),

          // Data & Storage Section
          _buildSectionHeader('Data & Storage'),
          ListTile(
            leading: const Icon(Icons.sync, color: AppColors.primary),
            title: const Text('Sync Data'),
            subtitle: const Text('Last synced: 2 hours ago'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Syncing data...')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.storage, color: AppColors.primary),
            title: const Text('Clear Cache'),
            subtitle: const Text('Free up storage space'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showClearCacheDialog(),
          ),
          ListTile(
            leading: const Icon(Icons.backup, color: AppColors.primary),
            title: const Text('Backup & Restore'),
            subtitle: const Text('Manage your data backups'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Backup feature coming soon!')),
              );
            },
          ),

          const Divider(),

          // About Section
          _buildSectionHeader('About'),
          ListTile(
            leading: const Icon(Icons.info, color: AppColors.primary),
            title: const Text('About CONSTRUCTIQ'),
            subtitle: const Text('Version 2.0.0 (Build 100)'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showAboutDialog(),
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip, color: AppColors.primary),
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.description, color: AppColors.primary),
            title: const Text('Terms of Service'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.help, color: AppColors.primary),
            title: const Text('Help & Support'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          const SizedBox(height: 32),

          // Logout Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OutlinedButton.icon(
              onPressed: () {
                authProvider.logout();
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
              },
              icon: const Icon(Icons.logout, color: AppColors.error),
              label: const Text('Logout', style: TextStyle(color: AppColors.error)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.error),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.grey600,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['English', 'Swahili', 'French', 'Spanish'].map((lang) {
            return RadioListTile<String>(
              title: Text(lang),
              value: lang,
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() => _selectedLanguage = value!);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showCurrencyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Currency'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['KES', 'USD', 'EUR', 'GBP'].map((currency) {
            return RadioListTile<String>(
              title: Text(currency),
              value: currency,
              groupValue: _selectedCurrency,
              onChanged: (value) {
                setState(() => _selectedCurrency = value!);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showClearCacheDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text('This will free up storage space. Continue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache cleared successfully!'), backgroundColor: AppColors.success),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'CONSTRUCTIQ',
      applicationVersion: '2.0.0',
      applicationIcon: const Icon(Icons.construction, size: 48, color: AppColors.primary),
      children: [
        const Text('AI-Powered Construction Field Intelligence & Universal Material Management Platform'),
        const SizedBox(height: 16),
        const Text('Built with Flutter for iOS & Android'),
        const SizedBox(height: 8),
        const Text('© 2026 CONSTRUCTIQ Team'),
      ],
    );
  }
}

