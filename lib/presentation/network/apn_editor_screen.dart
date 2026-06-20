import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../design/design_system.dart';
import '../../domain/entity/apn/apn_settings.dart';
import 'bloc/apn_cubit.dart';

/// Editable APN form, pre-filled from the current [settings]. Applying writes
/// back via [ApnCubit.save] (`postApnList`).
class ApnEditorScreen extends StatefulWidget {
  const ApnEditorScreen({super.key, required this.settings});

  final ApnSettings settings;

  @override
  State<ApnEditorScreen> createState() => _ApnEditorScreenState();
}

class _ApnEditorScreenState extends State<ApnEditorScreen> {
  late final _name = TextEditingController(text: widget.settings.name);
  late final _apn = TextEditingController(text: widget.settings.apn);
  late final _username = TextEditingController(text: widget.settings.username);
  late final _password = TextEditingController(text: widget.settings.password);
  late final _apnType = TextEditingController(text: widget.settings.apnType);
  late final _mvnoType = TextEditingController(text: widget.settings.mvnoType);
  late final _proxy = TextEditingController(text: widget.settings.proxy);
  late final _port = TextEditingController(text: widget.settings.port);
  late final _server = TextEditingController(text: widget.settings.server);
  late final _mmsc = TextEditingController(text: widget.settings.mmsc);
  late final _mmsProxy = TextEditingController(text: widget.settings.mmsProxy);
  late final _mmsPort = TextEditingController(text: widget.settings.mmsPort);
  late final _mcc = TextEditingController(text: widget.settings.mcc);
  late final _mnc = TextEditingController(text: widget.settings.mnc);

  late ApnAuthType _authType = widget.settings.authType;
  late ApnProtocol _protocol = widget.settings.protocol;
  late ApnProtocol _roaming = widget.settings.roamingProtocol;

  bool _showPassword = false;
  bool _saving = false;

  final _controllers = <TextEditingController>[];

  @override
  void initState() {
    super.initState();
    _controllers.addAll([
      _name, _apn, _username, _password, _apnType, _mvnoType, _proxy, _port,
      _server, _mmsc, _mmsProxy, _mmsPort, _mcc, _mnc,
    ]);
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  ApnSettings _draft() => ApnSettings(
        name: _name.text,
        apn: _apn.text,
        username: _username.text,
        password: _password.text,
        proxy: _proxy.text,
        port: _port.text,
        server: _server.text,
        mmsc: _mmsc.text,
        mmsProxy: _mmsProxy.text,
        mmsPort: _mmsPort.text,
        mcc: _mcc.text,
        mnc: _mnc.text,
        apnType: _apnType.text,
        mvnoType: _mvnoType.text,
        authType: _authType,
        protocol: _protocol,
        roamingProtocol: _roaming,
      );

  void _apply() async {
    if (_saving) return;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    setState(() => _saving = true);
    final ok = await context.read<ApnCubit>().save(_draft());
    if (!mounted) return;
    setState(() => _saving = false);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(ok ? 'APN updated' : 'Failed to update APN'),
      ));
    if (ok) navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('APN settings')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.xxxl,
          ),
          children: [
            const _SectionLabel('Access point'),
            _field('Name', _name),
            _field('APN', _apn),
            _field('Username', _username),
            _passwordField(),
            _dropdown<ApnAuthType>(
              label: 'Identity authentication',
              value: _authType,
              values: ApnAuthType.values,
              labelOf: (v) => v.label,
              onChanged: (v) => setState(() => _authType = v),
            ),
            _dropdown<ApnProtocol>(
              label: 'APN protocol',
              value: _protocol,
              values: ApnProtocol.values,
              labelOf: (v) => v.label,
              onChanged: (v) => setState(() => _protocol = v),
            ),
            _dropdown<ApnProtocol>(
              label: 'APN roaming protocol',
              value: _roaming,
              values: ApnProtocol.values,
              labelOf: (v) => v.label,
              onChanged: (v) => setState(() => _roaming = v),
            ),
            _field('APN type', _apnType),
            _field('MVNO type', _mvnoType),
            const SizedBox(height: AppSpacing.lg),
            const _SectionLabel('Proxy & MMS'),
            _field('Proxy', _proxy),
            _field('Port', _port, keyboardType: TextInputType.number),
            _field('Server', _server),
            _field('MMSC', _mmsc),
            _field('MMS proxy', _mmsProxy),
            _field('MMS port', _mmsPort, keyboardType: TextInputType.number),
            const SizedBox(height: AppSpacing.lg),
            const _SectionLabel('Carrier'),
            _field('MCC', _mcc, keyboardType: TextInputType.number),
            _field('MNC', _mnc, keyboardType: TextInputType.number),
            const SizedBox(height: AppSpacing.xl),
            FilledButton(
              onPressed: _saving ? null : _apply,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: _saving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Apply'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController controller, {
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: TextField(
        controller: _password,
        obscureText: !_showPassword,
        decoration: InputDecoration(
          labelText: 'Password',
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(
              _showPassword ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () => setState(() => _showPassword = !_showPassword),
          ),
        ),
      ),
    );
  }

  Widget _dropdown<T>({
    required String label,
    required T value,
    required List<T> values,
    required String Function(T) labelOf,
    required ValueChanged<T> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: DropdownButtonFormField<T>(
        initialValue: value,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: [
          for (final v in values)
            DropdownMenuItem<T>(value: v, child: Text(labelOf(v))),
        ],
        onChanged: (v) {
          if (v != null) onChanged(v);
        },
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Text(
        text.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 1.3,
              color: AppColors.white.withValues(alpha: 0.5),
            ),
      ),
    );
  }
}
