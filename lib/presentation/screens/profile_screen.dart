import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../state/providers/preferences_providers.dart';
import '../widgets/frosted_card.dart';

/// Profile screen with preferences and about section.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  String _getThemeDisplay(String theme) {
    switch (theme) {
      case 'light':
        return 'Light';
      case 'dark':
        return 'Dark';
      default:
        return 'System default';
    }
  }

  String _getCurrencyDisplay(String currency) {
    switch (currency) {
      case 'USD':
        return 'USD (\$)';
      case 'EUR':
        return 'EUR (€)';
      case 'GBP':
        return 'GBP (£)';
      case 'INR':
        return 'INR (₹)';
      default:
        return 'USD (\$)';
    }
  }

  String _getRoundingDisplay(String rounding) {
    switch (rounding) {
      case 'cent':
        return 'Round to nearest cent';
      case 'dollar':
        return 'Round to nearest dollar';
      case 'none':
        return 'No rounding';
      default:
        return 'Round to nearest cent';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(preferencesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Preferences Section
            Text(
              'Preferences',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            FrostedCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Theme'),
                    subtitle: Text(_getThemeDisplay(preferences.theme)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Select Theme'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RadioListTile<String>(
                                title: const Text('System default'),
                                value: 'system',
                                groupValue: preferences.theme,
                                onChanged: (value) {
                                  if (value != null) {
                                    ref
                                        .read(preferencesProvider.notifier)
                                        .setTheme(value);
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                              RadioListTile<String>(
                                title: const Text('Light'),
                                value: 'light',
                                groupValue: preferences.theme,
                                onChanged: (value) {
                                  if (value != null) {
                                    ref
                                        .read(preferencesProvider.notifier)
                                        .setTheme(value);
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                              RadioListTile<String>(
                                title: const Text('Dark'),
                                value: 'dark',
                                groupValue: preferences.theme,
                                onChanged: (value) {
                                  if (value != null) {
                                    ref
                                        .read(preferencesProvider.notifier)
                                        .setTheme(value);
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text('Currency'),
                    subtitle: Text(_getCurrencyDisplay(preferences.currency)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Select Currency'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RadioListTile<String>(
                                title: const Text('USD (\$)'),
                                value: 'USD',
                                groupValue: preferences.currency,
                                onChanged: (value) {
                                  if (value != null) {
                                    ref
                                        .read(preferencesProvider.notifier)
                                        .setCurrency(value);
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                              RadioListTile<String>(
                                title: const Text('EUR (€)'),
                                value: 'EUR',
                                groupValue: preferences.currency,
                                onChanged: (value) {
                                  if (value != null) {
                                    ref
                                        .read(preferencesProvider.notifier)
                                        .setCurrency(value);
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                              RadioListTile<String>(
                                title: const Text('GBP (£)'),
                                value: 'GBP',
                                groupValue: preferences.currency,
                                onChanged: (value) {
                                  if (value != null) {
                                    ref
                                        .read(preferencesProvider.notifier)
                                        .setCurrency(value);
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                              RadioListTile<String>(
                                title: const Text('INR (₹)'),
                                value: 'INR',
                                groupValue: preferences.currency,
                                onChanged: (value) {
                                  if (value != null) {
                                    ref
                                        .read(preferencesProvider.notifier)
                                        .setCurrency(value);
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text('Rounding'),
                    subtitle: Text(_getRoundingDisplay(preferences.rounding)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Select Rounding'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RadioListTile<String>(
                                title: const Text('Round to nearest cent'),
                                value: 'cent',
                                groupValue: preferences.rounding,
                                onChanged: (value) {
                                  if (value != null) {
                                    ref
                                        .read(preferencesProvider.notifier)
                                        .setRounding(value);
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                              RadioListTile<String>(
                                title: const Text('Round to nearest dollar'),
                                value: 'dollar',
                                groupValue: preferences.rounding,
                                onChanged: (value) {
                                  if (value != null) {
                                    ref
                                        .read(preferencesProvider.notifier)
                                        .setRounding(value);
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                              RadioListTile<String>(
                                title: const Text('No rounding'),
                                value: 'none',
                                groupValue: preferences.rounding,
                                onChanged: (value) {
                                  if (value != null) {
                                    ref
                                        .read(preferencesProvider.notifier)
                                        .setRounding(value);
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text('Manage People'),
                    subtitle: const Text('Edit saved people'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      context.push('/manage-people');
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // About Section
            Text(
              'About',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            FrostedCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Evenly',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'An offline-first, privacy-focused receipt splitting app.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Open Source'),
                    subtitle: const Text('View on GitHub'),
                    leading: const Icon(Icons.code),
                    onTap: () async {
                      final url = Uri.parse('https://github.com/sravan1946/Evenly');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url, mode: LaunchMode.externalApplication);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
