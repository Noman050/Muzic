// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:music_app/consts/colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // General settings
  String _selectedTheme = 'Light';
  String _selectedLanguage = 'English';
  String _selectedCrossfade = 'Off';
  bool _isGaplessPlaybackEnabled = false;
  String _selectedRepeat = 'Off';
  bool _isShuffleEnabled = false;
  String _selectedSleepTimer = 'Off';
  bool _isScrobbleEnabled = false;

  // Audio settings
  String _selectedEqualizer = 'Off';
  String _selectedAudioEffectBassBoost = 'Low';
  bool _isVirtualizerEnabled = false;
  bool _isLoudnessEnhancerEnabled = false;
  String _selectedReverb = 'None';
  String _selectedAudioQuality = 'Medium';

  // Notification settings
  bool _isNowPlayingNotificationEnabled = true;
  String _selectedNotificationStyle = 'Compact';
  bool _isPlayPauseControlEnabled = true;
  bool _isPreviousTrackControlEnabled = true;
  bool _isNextTrackControlEnabled = true;

  // Device settings
  String _selectedStorageLocation = 'Internal Storage';

  // Account settings
  bool _isSyncLibraryEnabled = true;
  bool _isSyncFavoritesEnabled = true;
  bool _isSyncPlaylistsEnabled = true;
  bool _isSyncPlayHistoryEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: buttonColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // General Settings
          ListTile(
            title: const Text('Theme'),
            trailing: DropdownButton<String>(
              value: _selectedTheme,
              onChanged: (value) {
                setState(() {
                  _selectedTheme = value!;
                });
              },
              items: ['Light', 'Dark', 'Custom'].map((String theme) {
                return DropdownMenuItem<String>(
                  value: theme,
                  child: Text(theme),
                );
              }).toList(),
            ),
          ),
          ListTile(
            title: const Text('Language'),
            trailing: DropdownButton<String>(
              value: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
              },
              items: [
                'English',
                'Spanish',
                'French',
                'German',
                'Japanese',
                'Chinese (Simplified)',
                'Chinese (Traditional)',
                'Other'
              ].map((String language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(language),
                );
              }).toList(),
            ),
          ),
          const ListTile(
            title: Text('Playback Settings'),
            subtitle: Text('Configure how the music is played back'),
          ),
          SwitchListTile(
            title: const Text('Gapless Playback'),
            value: _isGaplessPlaybackEnabled,
            onChanged: (value) {
              setState(() {
                _isGaplessPlaybackEnabled = value;
              });
            },
          ),
          ListTile(
            title: const Text('Crossfade'),
            trailing: DropdownButton<String>(
              value: _selectedCrossfade,
              onChanged: (value) {
                setState(() {
                  _selectedCrossfade = value!;
                });
              },
              items: ['Off', '3 seconds', '5 seconds', '10 seconds']
                  .map((String crossfade) {
                return DropdownMenuItem<String>(
                  value: crossfade,
                  child: Text(crossfade),
                );
              }).toList(),
            ),
          ),
          ListTile(
            title: const Text('Repeat'),
            trailing: DropdownButton<String>(
              value: _selectedRepeat,
              onChanged: (value) {
                setState(() {
                  _selectedRepeat = value!;
                });
              },
              items: ['Off', 'All', 'One', 'Folder'].map((String repeat) {
                return DropdownMenuItem<String>(
                  value: repeat,
                  child: Text(repeat),
                );
              }).toList(),
            ),
          ),
          SwitchListTile(
            title: const Text('Shuffle'),
            value: _isShuffleEnabled,
            onChanged: (value) {
              setState(() {
                _isShuffleEnabled = value;
              });
            },
          ),
          ListTile(
            title: const Text('Sleep Timer'),
            trailing: DropdownButton<String>(
              value: _selectedSleepTimer,
              onChanged: (value) {
                setState(() {
                  _selectedSleepTimer = value!;
                });
              },
              items: [
                'Off',
                '15 minutes',
                '30 minutes',
                '1 hour',
                'Custom'
              ].map((String sleepTimer) {
                return DropdownMenuItem<String>(
                  value: sleepTimer,
                  child: Text(sleepTimer),
                );
              }).toList(),
            ),
          ),
          SwitchListTile(
            title: const Text('Scrobble to Last.fm'),
            value: _isScrobbleEnabled,
            onChanged: (value) {
              setState(() {
                _isScrobbleEnabled = value;
              });
            },
          ),

          // Audio Settings
          ListTile(
            title: const Text('Equalizer'),
            trailing: DropdownButton<String>(
              value: _selectedEqualizer,
              onChanged: (value) {
                setState(() {
                  _selectedEqualizer = value!;
                });
              },
              items: ['Off', 'Custom', 'Normal', 'Classical', 'Dance', 'Pop', 'Rock', 'Jazz', 'Vocal']
                  .map((String equalizer) {
                return DropdownMenuItem<String>(
                  value: equalizer,
                  child: Text(equalizer),
                );
              }).toList(),
            ),
          ),
          const ListTile(
            title: Text('Audio Effects'),
          ),
          SwitchListTile(
            title: const Text('Bass Boost'),
            value: _selectedAudioEffectBassBoost != 'Off',
            onChanged: (value) {
              setState(() {
                _selectedAudioEffectBassBoost = value ? 'Low' : 'Off';
              });
            },
          ),
          SwitchListTile(
            title: const Text('Virtualizer'),
            value: _isVirtualizerEnabled,
            onChanged: (value) {
              setState(() {
                _isVirtualizerEnabled = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Loudness Enhancer'),
            value: _isLoudnessEnhancerEnabled,
            onChanged: (value) {
              setState(() {
                _isLoudnessEnhancerEnabled = value;
              });
            },
          ),
          ListTile(
            title: const Text('Reverb'),
            trailing: DropdownButton<String>(
              value: _selectedReverb,
              onChanged: (value) {
                setState(() {
                  _selectedReverb = value!;
                });
              },
              items: ['None', 'Small Room', 'Medium Room', 'Large Room', 'Hall', 'Auditorium']
                  .map((String reverb) {
                return DropdownMenuItem<String>(
                  value: reverb,
                  child: Text(reverb),
                );
              }).toList(),
            ),
          ),
          ListTile(
            title: const Text('Audio Quality'),
            trailing: DropdownButton<String>(
              value: _selectedAudioQuality,
              onChanged: (value) {
                setState(() {
                  _selectedAudioQuality = value!;
                });
              },
              items: ['Low', 'Medium', 'High'].map((String quality) {
                return DropdownMenuItem<String>(
                  value: quality,
                  child: Text(quality),
                );
              }).toList(),
            ),
          ),

          // Notification Settings
          SwitchListTile(
            title: const Text('Show Now Playing Notification'),
            value: _isNowPlayingNotificationEnabled,
            onChanged: (value) {
              setState(() {
                _isNowPlayingNotificationEnabled = value;
              });
            },
          ),
          ListTile(
            title: const Text('Notification Style'),
            trailing: DropdownButton<String>(
              value: _selectedNotificationStyle,
              onChanged: (value) {
                setState(() {
                  _selectedNotificationStyle = value!;
                });
              },
              items: ['Compact', 'Detailed'].map((String style) {
                return DropdownMenuItem<String>(
                  value: style,
                  child: Text(style),
                );
              }).toList(),
            ),
          ),
          CheckboxListTile(
            title: const Text('Play/Pause Control'),
            value: _isPlayPauseControlEnabled,
            onChanged: (value) {
              setState(() {
                _isPlayPauseControlEnabled = value!;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('Previous Track Control'),
            value: _isPreviousTrackControlEnabled,
            onChanged: (value) {
              setState(() {
                _isPreviousTrackControlEnabled = value!;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('Next Track Control'),
            value: _isNextTrackControlEnabled,
            onChanged: (value) {
              setState(() {
                _isNextTrackControlEnabled = value!;
              });
            },
          ),

          // Device Settings
          ListTile(
            title: const Text('Storage Location'),
            trailing: DropdownButton<String>(
              value: _selectedStorageLocation,
              onChanged: (value) {
                setState(() {
                  _selectedStorageLocation = value!;
                });
              },
              items: ['Internal Storage', 'External Storage'].map((String location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
            ),
          ),
          const ListTile(
            title: Text('Scanning Folders'),
          ),
          // Add Folder button
          // Remove Folder button
          // Rescan Library button

          // Account Settings
          const ListTile(
            title: Text('Account Information'),
          ),
          const ListTile(
            title: Text('Sync Settings'),
          ),
          SwitchListTile(
            title: const Text('Sync Library'),
            value: _isSyncLibraryEnabled,
            onChanged: (value) {
              setState(() {
                _isSyncLibraryEnabled = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Sync Favorites'),
            value: _isSyncFavoritesEnabled,
            onChanged: (value) {
              setState(() {
                _isSyncFavoritesEnabled = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Sync Playlists'),
            value: _isSyncPlaylistsEnabled,
            onChanged: (value) {
              setState(() {
                _isSyncPlaylistsEnabled = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Sync Play History'),
            value: _isSyncPlayHistoryEnabled,
            onChanged: (value) {
              setState(() {
                _isSyncPlayHistoryEnabled = value;
              });
            },
          ),

          // About
          ListTile(
            title: const Text('About'),
            subtitle: const Text('App Version'),
            onTap: () {
              // Open about screen
            },
          ),
          ListTile(
            title: const Text('Privacy Policy'),
            onTap: () {
              // Open privacy policy screen
            },
          ),
          ListTile(
            title: const Text('Terms of Service'),
            onTap: () {
              // Open terms of service screen
            },
          ),
          ListTile(
            title: const Text('Open Source Licenses'),
            onTap: () {
              // Open open source licenses screen
            },
          ),
          ListTile(
            title: const Text('Contact Us'),
            onTap: () {
              // Open contact us screen
            },
          ),
        ],
      ),
    );
  }
}
