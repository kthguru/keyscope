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
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../i18n.dart' show I18n;
import '../../connection/repository/connection_repository.dart';

class CreateKeyDialog extends ConsumerStatefulWidget {
  const CreateKeyDialog({super.key});

  @override
  ConsumerState<CreateKeyDialog> createState() => _CreateKeyDialogState();
}

class _CreateKeyDialogState extends ConsumerState<CreateKeyDialog> {
  final _formKey = GlobalKey<FormState>();

  // Form Controllers
  final _keyController = TextEditingController();
  final _ttlController = TextEditingController();

  // String / List / Set Value
  final _valueController = TextEditingController();

  // Hash (Field/Value)
  final _hashFieldController = TextEditingController();
  final _hashValueController = TextEditingController();

  // ZSet (Score/Member)
  final _zScoreController = TextEditingController();
  final _zMemberController = TextEditingController();

  String _selectedType = 'string';
  final List<String> _types = ['string', 'hash', 'list', 'set', 'zset'];

  @override
  Widget build(BuildContext context) => Dialog(
        backgroundColor: const Color(0xFF2B2D30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  I18n.of(context).createNewKey,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),

                // 1. Key Name & Type
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildTextField(
                        controller: _keyController,
                        label: I18n.of(context).keyName,
                        hint: '${I18n.of(context).eg} user:1001',
                        validator: (v) => v == null || v.isEmpty
                            ? I18n.of(context).required
                            : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: DropdownButtonFormField<String>(
                        initialValue: _selectedType, // value: _selectedType,
                        decoration: InputDecoration(
                          labelText: I18n.of(context).type,
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                        ),
                        dropdownColor: const Color(0xFF2B2D30),
                        items: _types
                            .map(
                              (t) => DropdownMenuItem(
                                value: t,
                                child: Text(t.toUpperCase()),
                              ),
                            )
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            _selectedType = val!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 2. Dynamic Value Input based on Type
                Text(
                  I18n.of(context).initialValue,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 8),
                _buildValueInputs(),

                const SizedBox(height: 16),

                // 3. TTL (Optional)
                _buildTextField(
                  controller: _ttlController,
                  label: I18n.of(context).ttlSecondsOptional,
                  hint: '-1 (${I18n.of(context).forever})',
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),

                const SizedBox(height: 24),

                // 4. Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(I18n.of(context).cancel),
                    ),
                    const SizedBox(width: 12),
                    FilledButton(
                        onPressed: _submit,
                        child: Text(I18n.of(context).create)),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildValueInputs() {
    switch (_selectedType) {
      case 'string':
        return _buildTextField(
          controller: _valueController,
          label: I18n.of(context).value,
          maxLines: 3,
          validator: (v) => v!.isEmpty ? I18n.of(context).required : null,
        );
      case 'hash':
        return Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _hashFieldController,
                label: I18n.of(context).field,
                validator: (v) => v!.isEmpty ? I18n.of(context).required : null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTextField(
                controller: _hashValueController,
                label: I18n.of(context).value,
                validator: (v) => v!.isEmpty ? I18n.of(context).required : null,
              ),
            ),
          ],
        );
      case 'list':
        return _buildTextField(
          controller: _valueController,
          label: I18n.of(context).initialItem,
          validator: (v) => v!.isEmpty ? I18n.of(context).required : null,
        );
      case 'set':
        return _buildTextField(
          controller: _valueController,
          label: I18n.of(context).member,
          validator: (v) => v!.isEmpty ? I18n.of(context).required : null,
        );
      case 'zset':
        return Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildTextField(
                controller: _zScoreController,
                label: I18n.of(context).score,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp('[0-9.]'),
                  ), // RegExp(r'[0-9.]')
                ],
                validator: (v) => v!.isEmpty ? I18n.of(context).required : null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: _buildTextField(
                controller: _zMemberController,
                label: I18n.of(context).member,
                validator: (v) => v!.isEmpty ? I18n.of(context).required : null,
              ),
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    int maxLines = 1,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) =>
      TextFormField(
        controller: controller,
        maxLines: maxLines,
        inputFormatters: inputFormatters,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          isDense: true,
          border: const OutlineInputBorder(),
        ),
      );

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final repo = ref.read(connectionRepositoryProvider);
    final key = _keyController.text;
    final ttl = int.tryParse(_ttlController.text);

    dynamic value;
    try {
      // Prepare value payload
      switch (_selectedType) {
        case 'string':
        case 'list':
        case 'set':
          value = _valueController.text;
          break;
        case 'hash':
          value = {_hashFieldController.text: _hashValueController.text};
          break;
        case 'zset':
          value = {_zMemberController.text: num.parse(_zScoreController.text)};
          break;
      }

      await repo.createKey(
        key: key,
        type: _selectedType,
        value: value,
        ttl: ttl,
      );

      if (!mounted) return;
      Navigator.pop(context, true); // Return true to indicate success
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('${I18n.of(context).error}: $e'),
            backgroundColor: Colors.red),
      );
    }
  }
}
