/*
 * Copyright 2025-2026 Infradise Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../i18n.dart';
import '../../data/language_data.dart';
import '../../providers/language_provider.dart';

class AdvancedLanguageSelectorSheet extends ConsumerStatefulWidget {
  const AdvancedLanguageSelectorSheet({super.key});

  @override
  ConsumerState<AdvancedLanguageSelectorSheet> createState() =>
      _AdvancedLanguageSelectorSheetState();
}

class _AdvancedLanguageSelectorSheetState
    extends ConsumerState<AdvancedLanguageSelectorSheet> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final currentLanguageCode =
        ref.watch(languageProvider.select((p) => p.languageCode));
    final currentLanguage =
        allLanguages.firstWhere((lang) => lang.code == currentLanguageCode);

    final recentLanguages = ref
        .watch(languageProvider)
        .recentLanguages
        .where((lang) => lang.code != currentLanguageCode)
        .toList();

    final filteredLanguages = allLanguages.where((lang) {
      if (lang.code == currentLanguageCode) return false;

      final query = _searchQuery.toLowerCase();
      if (_searchQuery.isEmpty) return true;

      return lang.name.toLowerCase().contains(query) ||
          lang.code.toLowerCase().contains(query);
    }).toList();

    return DraggableScrollableSheet(
      expand: false,
      // Languages: 50+
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      builder: (_, scrollController) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                  hintText: I18n.of(context).searchLanguages,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16)),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  if (_searchQuery.isEmpty) ...[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(I18n.of(context).currentlyUsedLanguage,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: ListTile(
                        title: Text(currentLanguage.name,
                            style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold)),
                        trailing: const Icon(Icons.check, color: Colors.blue),
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ),
                    const SliverToBoxAdapter(child: Divider()),
                  ],
                  if (_searchQuery.isEmpty && recentLanguages.isNotEmpty) ...[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(I18n.of(context).recentlyUsedLanguages,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SliverList.builder(
                      itemCount: recentLanguages.length,
                      itemBuilder: (context, index) {
                        final language = recentLanguages[index];
                        return ListTile(
                          title: Text(language.name),
                          onTap: () {
                            ref
                                .read(languageProvider.notifier)
                                .changeLanguage(language.code);
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    ),
                    const SliverToBoxAdapter(child: Divider()),
                  ],
                  if (_searchQuery.isEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(I18n.of(context).allLanguages,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  SliverList.builder(
                    itemCount: filteredLanguages.length,
                    itemBuilder: (context, index) {
                      final language = filteredLanguages[index];
                      return ListTile(
                        title: Text(language.name),
                        // subtitle: Text(language.code),
                        onTap: () {
                          ref
                              .read(languageProvider.notifier)
                              .changeLanguage(language.code);
                          Navigator.of(context).pop();
                        },
                      );
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
