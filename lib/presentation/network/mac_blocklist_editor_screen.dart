import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../design/design_system.dart';
import '../../domain/entity/mac_filter/mac_filter.dart';
import 'bloc/mac_filter_cubit.dart';
import 'mac_filter_restart_dialog.dart';

/// Edits the MAC deny list as a growing set of input rows (up to
/// [MacFilter.maxEntries]). Applying writes the whole list and enables the
/// deny filter via [MacFilterCubit.saveBlocklist].
class MacBlocklistEditorScreen extends StatefulWidget {
  const MacBlocklistEditorScreen({super.key, required this.initialMacs});

  final List<String> initialMacs;

  @override
  State<MacBlocklistEditorScreen> createState() =>
      _MacBlocklistEditorScreenState();
}

class _MacBlocklistEditorScreenState extends State<MacBlocklistEditorScreen> {
  static final _macPattern =
      RegExp(r'^([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}$');

  late final List<_MacField> _fields;

  @override
  void initState() {
    super.initState();
    _fields = widget.initialMacs.isEmpty
        ? [_MacField()]
        : widget.initialMacs.map((m) => _MacField(m)).toList();
  }

  @override
  void dispose() {
    for (final f in _fields) {
      f.controller.dispose();
    }
    super.dispose();
  }

  void _addField() {
    if (_fields.length >= MacFilter.maxEntries) return;
    setState(() => _fields.add(_MacField()));
  }

  void _removeField(int index) {
    setState(() {
      _fields[index].controller.dispose();
      _fields.removeAt(index);
      if (_fields.isEmpty) _fields.add(_MacField());
    });
  }

  void _apply() async {
    final macs = <String>[];
    final seen = <String>{};
    var hasError = false;

    setState(() {
      for (final field in _fields) {
        final value = field.controller.text.trim().toUpperCase();
        if (value.isEmpty) {
          field.error = null;
          continue;
        }
        if (!_macPattern.hasMatch(value)) {
          field.error = 'Invalid MAC address';
          hasError = true;
          continue;
        }
        if (!seen.add(value)) {
          field.error = 'Duplicate';
          hasError = true;
          continue;
        }
        field.error = null;
        macs.add(value);
      }
    });

    if (hasError) return;

    final cubit = context.read<MacFilterCubit>();
    final navigator = Navigator.of(context);
    if (!await confirmMacFilterRestart(context)) return;
    if (!mounted) return;
    cubit.saveBlocklist(macs);
    navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final canAdd = _fields.length < MacFilter.maxEntries;
    return Scaffold(
      appBar: AppBar(title: const Text('Edit blocklist')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.md,
                  AppSpacing.lg,
                  AppSpacing.lg,
                ),
                children: [
                  Text(
                    'Devices listed here are denied access. '
                    'Up to ${MacFilter.maxEntries} addresses.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color:
                              AppColors.white.withValues(alpha: 0.55),
                        ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  for (var i = 0; i < _fields.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _fields[i].controller,
                              textCapitalization: TextCapitalization.characters,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9A-Fa-f:]'),
                                ),
                              ],
                              decoration: InputDecoration(
                                labelText: 'MAC ${i + 1}',
                                hintText: 'AA:BB:CC:DD:EE:FF',
                                errorText: _fields[i].error,
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                          IconButton(
                            tooltip: 'Remove',
                            onPressed: () => _removeField(i),
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                    ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: canAdd ? _addField : null,
                      icon: const Icon(Icons.add),
                      label: Text(
                        canAdd
                            ? 'Add address'
                            : 'Maximum ${MacFilter.maxEntries} reached',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Pinned footer so Apply stays reachable as the list grows.
            Container(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppColors.white.withValues(alpha: 0.08),
                  ),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _apply,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                    child: Text('Apply'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MacField {
  _MacField([String text = '']) : controller = TextEditingController(text: text);

  final TextEditingController controller;
  String? error;
}
