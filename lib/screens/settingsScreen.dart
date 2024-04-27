// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:music_app/consts/colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isAppVersionExpanded = false;
  bool _isPrivacyPolicyExpanded = false;
  bool _isTermsExpanded = false;
  bool _isNotificationsExpanded = false;
  bool _isThemeExpanded = false;
  bool _isLanguageExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(letterSpacing: 1),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('About the App'),
            ListTile(
              leading: const Icon(
                Icons.info,
                color: buttonColor,
              ),
              title: const Text(
                'App Version',
                style: TextStyle(color: whiteColor),
              ),
              onTap: () {
                setState(() {
                  _isAppVersionExpanded = !_isAppVersionExpanded;
                });
              },
            ),
            if (_isAppVersionExpanded) ..._buildAppVersionDetails(),
            ListTile(
              leading: const Icon(
                Icons.security,
                color: buttonColor,
              ),
              title: const Text(
                'Privacy Policy',
                style: TextStyle(color: whiteColor),
              ),
              onTap: () {
                setState(() {
                  _isPrivacyPolicyExpanded = !_isPrivacyPolicyExpanded;
                });
              },
            ),
            if (_isPrivacyPolicyExpanded) ..._buildPrivacyPolicyDetails(),
            ListTile(
              leading: const Icon(
                Icons.article,
                color: buttonColor,
              ),
              title: const Text(
                'Terms and Conditions',
                style: TextStyle(color: whiteColor),
              ),
              onTap: () {
                setState(() {
                  _isTermsExpanded = !_isTermsExpanded;
                });
              },
            ),
            if (_isTermsExpanded) ..._buildTermsDetails(),
            const Divider(),
            _buildSectionHeader('General Settings'),
            ListTile(
              leading: const Icon(
                Icons.notifications,
                color: buttonColor,
              ),
              title: const Text(
                'Notifications',
                style: TextStyle(color: whiteColor),
              ),
              onTap: () {
                setState(() {
                  _isNotificationsExpanded = !_isNotificationsExpanded;
                });
              },
            ),
            if (_isNotificationsExpanded) ..._buildNotificationsDetails(),
            ListTile(
              leading: const Icon(
                Icons.style,
                color: buttonColor,
              ),
              title: const Text(
                'Theme',
                style: TextStyle(color: whiteColor),
              ),
              onTap: () {
                setState(() {
                  _isThemeExpanded = !_isThemeExpanded;
                });
              },
            ),
            if (_isThemeExpanded) ..._buildThemeDetails(),
            ListTile(
              leading: const Icon(
                Icons.language,
                color: buttonColor,
              ),
              title: const Text(
                'Language',
                style: TextStyle(color: whiteColor),
              ),
              onTap: () {
                setState(() {
                  _isLanguageExpanded = !_isLanguageExpanded;
                });
              },
            ),
            if (_isLanguageExpanded) ..._buildLanguageDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: whiteColor),
      ),
    );
  }

  List<Widget> _buildAppVersionDetails() {
    return [
      const ListTile(
        title: Text(
          'App Version',
          style: TextStyle(color: whiteColor),
        ),
        subtitle: Text(
          '1.0.0',
          style: TextStyle(color: whiteColor),
        ),
      ),
      const ListTile(
        title: Text(
          'Version Code',
          style: TextStyle(color: whiteColor),
        ),
        subtitle: Text(
          '100',
          style: TextStyle(color: whiteColor),
        ),
      ),
      // Add more details as needed
    ];
  }

  List<Widget> _buildPrivacyPolicyDetails() {
    return [
      const ListTile(
        title: Text(
          'Privacy Policy',
          style: TextStyle(color: whiteColor),
        ),
        subtitle: Text(
          'Your privacy is important to us. We value the trust you place in our app and strive to handle your personal information securely and responsibly. Our privacy policy outlines the types of information we collect, how we use and protect that information, and your rights regarding your personal information.',
          style: TextStyle(color: whiteColor),
        ),
      ),
      // Add more details as needed
    ];
  }

  List<Widget> _buildTermsDetails() {
    return [
      const ListTile(
        title: Text(
          'Terms and Conditions',
          style: TextStyle(color: whiteColor),
        ),
        subtitle: Text(
          'By using our app, you agree to comply with the terms and conditions set forth in this agreement. These terms and conditions govern your use of the app and any services offered within the app. It is important to read and understand these terms and conditions before using our app.',
          style: TextStyle(color: whiteColor),
        ),
      ),
      // Add more details as needed
    ];
  }

  List<Widget> _buildNotificationsDetails() {
    return [
      const ListTile(
        title: Text(
          'Notifications',
          style: TextStyle(color: whiteColor),
        ),
        subtitle: Text(
          'Manage your notification preferences to stay up-to-date with the latest updates, new releases, and personalized recommendations.',
          style: TextStyle(color: whiteColor),
        ),
      ),
      // Add more details as needed
    ];
  }

  List<Widget> _buildThemeDetails() {
    return [
      const ListTile(
        title: Text(
          'Theme',
          style: TextStyle(color: whiteColor),
        ),
        subtitle: Text(
          'Customize the look and feel of the app by selecting your preferred theme. Choose from light, dark, or system default themes.',
          style: TextStyle(color: whiteColor),
        ),
      ),
      // Add more details as needed
    ];
  }

  List<Widget> _buildLanguageDetails() {
    return [
      const ListTile(
        title: Text(
          'Language',
          style: TextStyle(color: whiteColor),
        ),
        subtitle: Text(
          'Select your preferred language for the app. Choose from a list of available languages.',
          style: TextStyle(color: whiteColor),
        ),
      ),
      // Add more details as needed
    ];
  }
}
