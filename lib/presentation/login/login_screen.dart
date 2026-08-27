import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../data/shared_preferences/prefs_repository.dart';
import '../../design/design_system.dart';
import '../../l10n/app_localizations.dart';
import '../home/home_route.dart';
import 'bloc/login_cubit.dart';
import 'bloc/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Lets the fixed button footer ride up to sit right above the keyboard.
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Bottom inset handled explicitly on the footer below, not by
          // SafeArea, so the button gap is derived from the live insets.
          SafeArea(
            bottom: false,
            // LayoutBuilder is the core responsive primitive: it hands us the
            // actual space this screen gets, so the layout decision is made
            // from real constraints rather than a guessed device class. A wide,
            // landscape-ish viewport (landscape phone or a tablet on its side)
            // splits into two panes; everything else keeps the stacked column.
            child: LayoutBuilder(
              builder: (context, constraints) {
                final twoPane = constraints.maxWidth >= 600 &&
                    constraints.maxWidth > constraints.maxHeight;
                return twoPane
                    ? const _WideLayout()
                    : const _NarrowLayout();
              },
            ),
          ),
          const SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.md),
                child: _ThemeToggleButton(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Portrait / phone layout: brand, heading and fields scroll together as one
/// region while the CTA stays pinned above the keyboard.
class _NarrowLayout extends StatelessWidget {
  const _NarrowLayout();

  @override
  Widget build(BuildContext context) {
    final dimens = AppDimensions.of(context);
    // Derive the bottom clearance from MediaQuery rather than a magic number.
    // `padding.bottom` is the safe area still *exposed*: it equals the gesture
    // bar / home-indicator inset when the keyboard is down, and collapses to 0
    // once the keyboard covers it — so the pinned footer keeps one consistent
    // gap above whichever of the two is currently there.
    final mq = MediaQuery.of(context);
    final exposedSafeBottom = mq.padding.bottom;
    return ResponsiveCenter(
      maxWidth: 460,
      padding: EdgeInsets.fromLTRB(
        dimens.screenPadding,
        dimens.screenPadding,
        dimens.screenPadding,
        dimens.screenPadding + exposedSafeBottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Logo, heading and fields scroll together as one region. The logo
          // always stays put and simply scrolls up when the keyboard leaves
          // little room — no appearing/disappearing — while the button below
          // stays pinned above the keyboard.
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Breathing room above the logo, proportional to the screen;
                  // scrolls off when space is tight.
                  SizedBox(height: mq.size.height * 0.08),
                  _BrandHero(iconSize: dimens.heroIconSize),
                  const SizedBox(height: AppSpacing.xl),
                  const _Heading(),
                  const SizedBox(height: AppSpacing.xxl),
                  const _Fields(),
                ],
              ),
            ),
          ),
          // Pinned CTA footer: outside the scroll view, so the Scaffold lifts
          // it to sit right above the keyboard when it's open.
          const SizedBox(height: AppSpacing.lg),
          const _SubmitButton(),
        ],
      ),
    );
  }
}

/// Wide / landscape layout: a brand pane beside the form pane, so the content
/// fills the space instead of stranding a narrow column in an empty screen and
/// the form isn't crushed under the keyboard in landscape. Each pane is
/// independently scrollable and vertically centered.
class _WideLayout extends StatelessWidget {
  const _WideLayout();

  @override
  Widget build(BuildContext context) {
    final dimens = AppDimensions.of(context);
    final mq = MediaQuery.of(context);
    final exposedSafeBottom = mq.padding.bottom;
    return Row(
      children: [
        // Brand pane — the hero + heading, centered in its half.
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(dimens.screenPadding),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _BrandHero(iconSize: dimens.heroIconSize),
                    const SizedBox(height: AppSpacing.xl),
                    const _Heading(),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Form pane — fields scroll, CTA pinned at the bottom of the pane.
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              dimens.screenPadding,
              dimens.screenPadding,
              dimens.screenPadding,
              dimens.screenPadding + exposedSafeBottom,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      child: SingleChildScrollView(
                        child: const _Fields(),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    const _SubmitButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// "Welcome back" title + subtitle, shared by both layouts.
class _Heading extends StatelessWidget {
  const _Heading();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Text(
          'Welcome back',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Sign in to manage your router',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
        ),
      ],
    );
  }
}

/// Username + password fields and the "stay signed in" row, shared by both
/// layouts. Reads the [LoginCubit] provided above the route.
class _Fields extends StatelessWidget {
  const _Fields();

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _LoginField(
          label: l10n.adminUsername,
          icon: Icons.person_outline,
          initialValue: loginCubit.state.username,
          textInputAction: TextInputAction.next,
          onChanged: loginCubit.onUsernameChange,
        ),
        const SizedBox(height: AppSpacing.lg),
        _LoginField(
          label: l10n.adminPassword,
          icon: Icons.lock_outline,
          obscurable: true,
          initialValue: loginCubit.state.password,
          textInputAction: TextInputAction.done,
          onChanged: loginCubit.onPasswordChange,
          onSubmitted: (_) => loginCubit.login(),
        ),
        const SizedBox(height: AppSpacing.md),
        _StaySignedInRow(loginCubit: loginCubit),
      ],
    );
  }
}

/// The primary sign-in button. Navigates home on success and surfaces failures
/// as a snackbar; shows a spinner while the request is in flight.
class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    return BlocConsumer<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
          previous.loginApiState != current.loginApiState,
      listener: (context, state) {
        if (state.loginApiState is LoginSuccessful) {
          context.go(HomeRoute.route);
        }

        if (state.loginApiState is LoginFailed) {
          final errorMessage = (state.loginApiState as LoginFailed).message;
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(errorMessage)));
        }
      },
      builder: (context, state) {
        final isLoading = state.loginApiState is LoginInProgress;
        return SizedBox(
          height: 52,
          child: FilledButton(
            onPressed: isLoading ? null : loginCubit.login,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.blue500,
              foregroundColor: colorScheme.onPrimary,
              disabledBackgroundColor: AppColors.blue500.withValues(alpha: 0.5),
              // Derive from the theme (rather than a bare TextStyle) so the
              // font family resolves consistently.
              textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
            ),
            child: isLoading
                ? SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      valueColor: AlwaysStoppedAnimation(
                        colorScheme.onPrimary,
                      ),
                    ),
                  )
                : Text(l10n.login),
          ),
        );
      },
    );
  }
}

/// Quick light/dark toggle in the corner of the login screen — sits ahead of
/// authentication, so it flips the explicit theme mode directly rather than
/// opening Settings, using the currently *effective* brightness (so it still
/// does the right thing when the user is on System).
class _ThemeToggleButton extends StatelessWidget {
  const _ThemeToggleButton();

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return IconButton(
      tooltip: isDark ? 'Switch to light theme' : 'Switch to dark theme',
      onPressed: () => PrefsRepository().setThemeMode(
        isDark ? ThemeMode.light : ThemeMode.dark,
      ),
      style: IconButton.styleFrom(
        backgroundColor: onSurface.withValues(alpha: 0.06),
        shape: const CircleBorder(),
      ),
      icon: Icon(
        isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
        color: onSurface.withValues(alpha: 0.75),
      ),
    );
  }
}

/// Brand-accented router glyph: a blue gradient tile with a soft glow, matching
/// the accent tiles used across the home dashboard.
class _BrandHero extends StatelessWidget {
  const _BrandHero({required this.iconSize});

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final blue = AppColors.blue500;
    final box = iconSize * 1.3;
    return Center(
      child: Container(
        width: box,
        height: box,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              blue.withValues(alpha: 0.28),
              blue.withValues(alpha: 0.08),
            ],
          ),
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: blue.withValues(alpha: 0.35)),
          boxShadow: [
            BoxShadow(
              color: blue.withValues(alpha: 0.35),
              blurRadius: 32,
              spreadRadius: -6,
            ),
          ],
        ),
        child: Icon(Icons.router, size: iconSize * 0.62, color: blue),
      ),
    );
  }
}

/// A glassy text field matching the app's surface cards — translucent fill,
/// hairline border that picks up the brand blue on focus, and a leading icon.
class _LoginField extends StatefulWidget {
  const _LoginField({
    required this.label,
    required this.icon,
    required this.onChanged,
    this.initialValue,
    this.obscurable = false,
    this.textInputAction,
    this.onSubmitted,
  });

  final String label;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final String? initialValue;
  final bool obscurable;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  @override
  State<_LoginField> createState() => _LoginFieldState();
}

class _LoginFieldState extends State<_LoginField> {
  late bool _obscured = widget.obscurable;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final muted = onSurface.withValues(alpha: 0.5);
    OutlineInputBorder border(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(color: color, width: width),
        );

    return TextFormField(
      initialValue: widget.initialValue,
      onChanged: widget.onChanged,
      obscureText: _obscured,
      enableSuggestions: !widget.obscurable,
      autocorrect: !widget.obscurable,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onSubmitted,
      style: const TextStyle(fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(color: muted),
        floatingLabelStyle: const TextStyle(color: AppColors.blue500),
        prefixIcon: Icon(widget.icon, color: muted, size: 20),
        suffixIcon: widget.obscurable
            ? IconButton(
                onPressed: () => setState(() => _obscured = !_obscured),
                icon: Icon(
                  _obscured ? Icons.visibility_off : Icons.visibility,
                  color: muted,
                  size: 20,
                ),
              )
            : null,
        filled: true,
        fillColor: onSurface.withValues(alpha: 0.045),
        border: border(onSurface.withValues(alpha: 0.07)),
        enabledBorder: border(onSurface.withValues(alpha: 0.07)),
        focusedBorder: border(AppColors.blue500, 1.4),
      ),
    );
  }
}

/// "Stay logged in" toggle row — tapping the label flips the checkbox too.
class _StaySignedInRow extends StatelessWidget {
  const _StaySignedInRow({required this.loginCubit});

  final LoginCubit loginCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final checked = state.isStaySignedInChecked;
        return InkWell(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          onTap: () => loginCubit.onSaveCredentialCheckBoxChange(!checked),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Row(
              children: [
                Checkbox(
                  value: checked,
                  activeColor: AppColors.blue500,
                  onChanged: (value) =>
                      loginCubit.onSaveCredentialCheckBoxChange(value!),
                ),
                Text(
                  AppLocalizations.of(context)!.stayLoggedIn,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
