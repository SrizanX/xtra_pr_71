import 'package:flutter/material.dart';

import '../../components/app_alert_dialog_widget.dart';

import '../../../data/network/api/router_control_api_service.dart';
import '../../../data/network/api/system_settings_api_service.dart';
import '../../../data/network/model/state_response.dart';
import '../../../domain/entity/system/time_status.dart';
import '../../../domain/result.dart';
import '../../../design/design_system.dart';
import 'timezone_options.dart';

/// Router system controls: admin password and time zone.
class SystemSettings extends StatelessWidget {
  const SystemSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.password),
          title: const Text('Admin password'),
          subtitle: const Text('Change the router login password'),
          trailing: Icon(
            Icons.chevron_right,
            color: AppColors.white.withValues(alpha: 0.4),
          ),
          onTap: () => showDialog<void>(
            context: context,
            builder: (_) => const _ChangePasswordDialog(),
          ),
        ),
        Divider(
          height: 1,
          color: AppColors.white.withValues(alpha: 0.08),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.schedule),
          title: const Text('Time zone'),
          subtitle: const Text('Set the router clock'),
          trailing: Icon(
            Icons.chevron_right,
            color: AppColors.white.withValues(alpha: 0.4),
          ),
          onTap: () => showDialog<void>(
            context: context,
            builder: (_) => const _TimezoneDialog(),
          ),
        ),
        Divider(
          height: 1,
          color: AppColors.white.withValues(alpha: 0.08),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(
            Icons.restore,
            color: Theme.of(context).colorScheme.error,
          ),
          title: Text(
            'Factory reset',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
          subtitle: const Text('Erase all settings and reboot'),
          onTap: () => _confirmFactoryReset(context),
        ),
      ],
    );
  }

  Future<void> _confirmFactoryReset(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => const AppAlertDialog(
        title: 'Factory reset?',
        message: 'This erases all router settings — Wi-Fi, APN, contacts, MAC '
            'filter — and reboots. You will be disconnected.',
        confirmLabel: 'Reset',
        confirmIcon: Icons.restart_alt,
        isDestructive: true,
      ),
    );
    if (confirmed != true) return;
    final result = await RouterControlApiService().factoryReset();
    // The router reboots as it resets, so the connection is expected to drop;
    // treat a successful acknowledgement as the router accepting the request.
    final ok = result is Successful<bool> && result.data;
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          ok
              ? 'Factory reset started — the router is rebooting'
              : 'Could not start factory reset',
        ),
      ),
    );
  }
}

class _ChangePasswordDialog extends StatefulWidget {
  const _ChangePasswordDialog();

  @override
  State<_ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<_ChangePasswordDialog> {
  final _old = TextEditingController();
  final _new = TextEditingController();
  final _confirm = TextEditingController();
  String? _error;
  bool _saving = false;

  static final _alnum = RegExp(r'^[A-Za-z0-9]+$');

  @override
  void dispose() {
    _old.dispose();
    _new.dispose();
    _confirm.dispose();
    super.dispose();
  }

  String? _validate() {
    final old = _old.text.trim();
    final next = _new.text.trim();
    final confirm = _confirm.text.trim();
    if (old.isEmpty) return 'Enter the current password';
    if (next.length < 4 || next.length > 20) {
      return 'New password must be 4–20 characters';
    }
    if (!_alnum.hasMatch(next)) return 'Use letters and numbers only';
    if (next != confirm) return 'Passwords do not match';
    return null;
  }

  void _save() async {
    final error = _validate();
    if (error != null) {
      setState(() => _error = error);
      return;
    }
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() {
      _error = null;
      _saving = true;
    });
    final result = await SystemSettingsApiService().changeAdminPassword(
      oldPassword: _old.text.trim(),
      newPassword: _new.text.trim(),
    );
    if (!mounted) return;
    final ok = result is Successful<StateResponse> && result.data.state == 1;
    if (ok) {
      navigator.pop();
      messenger.showSnackBar(
        const SnackBar(content: Text('Admin password changed')),
      );
    } else {
      setState(() {
        _saving = false;
        _error = 'Could not change password (check the current one)';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Change admin password'),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _field(_old, 'Current password'),
              const SizedBox(height: AppSpacing.md),
              _field(_new, 'New password'),
              const SizedBox(height: AppSpacing.md),
              _field(_confirm, 'Confirm new password', errorText: _error),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: _saving
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Save'),
        ),
      ],
    );
  }

  Widget _field(TextEditingController c, String label, {String? errorText}) {
    return TextField(
      controller: c,
      obscureText: true,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        errorText: errorText,
      ),
    );
  }
}

class _TimezoneDialog extends StatefulWidget {
  const _TimezoneDialog();

  @override
  State<_TimezoneDialog> createState() => _TimezoneDialogState();
}

class _TimezoneDialogState extends State<_TimezoneDialog> {
  bool _auto = false;
  bool _busyAuto = false;
  bool _loading = true;

  /// Current time-zone index (matches a `kTimezones` value) and clock, read
  /// from the status endpoint when the dialog opens.
  String? _currentValue;
  String _time = '';

  @override
  void initState() {
    super.initState();
    _loadStatus();
  }

  void _loadStatus() async {
    final result = await SystemSettingsApiService().fetchTimeStatus();
    if (!mounted) return;
    setState(() {
      _loading = false;
      if (result is Successful<TimeStatus>) {
        _auto = result.data.isAutoTimezone;
        _currentValue = result.data.timezone;
        _time = result.data.time;
      }
    });
  }

  void _toggleAuto() async {
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busyAuto = true);
    final result = await SystemSettingsApiService().toggleAutoTimeZone();
    if (!mounted) return;
    final ok = result is Successful<bool>;
    setState(() {
      _busyAuto = false;
      if (ok) _auto = result.data;
    });
    messenger.showSnackBar(
      SnackBar(
        content: Text(ok
            ? 'Automatic time zone ${_auto ? 'on' : 'off'}'
            : 'Could not change automatic time zone'),
      ),
    );
  }

  void _apply(TimezoneOption tz) async {
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final result = await SystemSettingsApiService().setTimezone(tz.value);
    final ok = result is Successful<StateResponse> && result.data.state == 1;
    navigator.pop();
    messenger.showSnackBar(
      SnackBar(
        content: Text(
            ok ? 'Time zone set to ${tz.label}' : 'Could not set time zone'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Time zone'),
      contentPadding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      content: SizedBox(
        width: double.maxFinite,
        height: 460,
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  if (_time.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.xs),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Router time · $_time',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                  SwitchListTile(
                    title: const Text('Automatic'),
                    subtitle: const Text('Set from the network'),
                    secondary: _busyAuto
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : null,
                    value: _auto,
                    onChanged: _busyAuto ? null : (_) => _toggleAuto(),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: ListView.builder(
                      itemCount: kTimezones.length,
                      itemBuilder: (context, index) {
                        final tz = kTimezones[index];
                        final selected = tz.value == _currentValue;
                        return ListTile(
                          dense: true,
                          enabled: !_auto,
                          selected: selected,
                          title: Text(tz.label),
                          trailing: selected
                              ? Icon(
                                  Icons.check,
                                  color:
                                      Theme.of(context).colorScheme.primary,
                                )
                              : null,
                          onTap: _auto ? null : () => _apply(tz),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
