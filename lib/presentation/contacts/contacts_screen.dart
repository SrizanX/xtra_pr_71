import 'package:flutter/material.dart';

import '../components/app_alert_dialog_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../design/design_system.dart';
import '../../domain/entity/contact/contact.dart';
import '../components/app_error_widget.dart';
import '../components/centered_progress_indicator.dart';
import '../components/surface_card.dart';
import 'bloc/contacts_cubit.dart';
import 'bloc/contacts_state.dart';

/// SIM phonebook: list contacts, add new ones, and delete them.
class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<ContactsCubit, ContactsState>(
          builder: (context, state) {
            return switch (state) {
              ContactsLoading() => const CenteredProgressIndicator(),
              ContactsFailed(:final errorMessage) => ErrorView(
                errorMessage: errorMessage,
                onRetry: () => context.read<ContactsCubit>().fetchContacts(),
              ),
              ContactsSuccessful() => _Content(state: state),
            };
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.person_add_alt_1),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<ContactsCubit>(),
        child: const _AddContactDialog(),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.state});

  final ContactsSuccessful state;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final contacts = state.contacts;
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.xxxl,
      ),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contacts',
                    style: textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '${contacts.length} on SIM',
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.white.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
            if (state.isBusy)
              const Padding(
                padding: EdgeInsets.only(right: AppSpacing.sm),
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            InkWell(
              onTap: () => context.read<ContactsCubit>().fetchContacts(),
              borderRadius: BorderRadius.circular(AppRadius.md + 2),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(AppRadius.md + 2),
                ),
                child: Icon(
                  Icons.refresh,
                  size: 21,
                  color: AppColors.white.withValues(alpha: 0.7),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        if (contacts.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxxl),
            child: Center(
              child: Text(
                'No contacts on the SIM',
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.white.withValues(alpha: 0.5),
                ),
              ),
            ),
          )
        else
          SurfaceCard(
            padding: EdgeInsets.zero,
            borderRadius: AppRadius.md + 2,
            child: Column(
              children: [
                for (var i = 0; i < contacts.length; i++) ...[
                  if (i > 0)
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.white.withValues(alpha: 0.06),
                    ),
                  _ContactTile(contact: contacts[i]),
                ],
              ],
            ),
          ),
      ],
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({required this.contact});

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm + 2,
      ),
      child: Row(
        children: [
          _Avatar(label: _initials(contact.displayName)),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact.displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                if (contact.name.trim().isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    contact.phone,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.white.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            tooltip: 'Delete',
            onPressed: () => _confirmDelete(context),
            icon: Icon(
              Icons.delete_outline,
              color: AppColors.white.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final cubit = context.read<ContactsCubit>();
    final messenger = ScaffoldMessenger.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AppAlertDialog(
        title: 'Delete contact?',
        message: 'Remove ${contact.displayName} from the SIM?',
        confirmLabel: 'Delete',
        confirmIcon: Icons.delete_outline,
        isDestructive: true,
      ),
    );
    if (confirmed != true) return;
    final ok = await cubit.deleteContacts([contact]);
    messenger.showSnackBar(
      SnackBar(content: Text(ok ? 'Contact deleted' : 'Delete failed')),
    );
  }

  String _initials(String label) {
    final cleaned = label.trim();
    if (cleaned.isEmpty) return '#';
    final parts = cleaned.split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    }
    return cleaned.length <= 2
        ? cleaned.toUpperCase()
        : cleaned.substring(0, 2).toUpperCase();
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.blue500.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(AppRadius.md + 2),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: label.length > 2 ? 12 : 15,
          fontWeight: FontWeight.w700,
          color: AppColors.blueLight,
        ),
      ),
    );
  }
}

class _AddContactDialog extends StatefulWidget {
  const _AddContactDialog();

  @override
  State<_AddContactDialog> createState() => _AddContactDialogState();
}

class _AddContactDialogState extends State<_AddContactDialog> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  String? _error;
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    super.dispose();
  }

  void _save() async {
    final phone = _phone.text.trim();
    if (phone.isEmpty) {
      setState(() => _error = 'Enter a phone number');
      return;
    }
    final cubit = context.read<ContactsCubit>();
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _saving = true);
    final ok = await cubit.addContact(name: _name.text.trim(), phone: phone);
    if (!mounted) return;
    navigator.pop();
    messenger.showSnackBar(
      SnackBar(content: Text(ok ? 'Contact added' : 'Could not add contact')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add contact'),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _name,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: _phone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone number',
                  border: const OutlineInputBorder(),
                  errorText: _error,
                ),
                onSubmitted: (_) => _save(),
              ),
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
              : const Text('Add'),
        ),
      ],
    );
  }
}
