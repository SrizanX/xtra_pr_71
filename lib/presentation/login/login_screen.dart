import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import '../../design/design_system.dart';
import '../../l10n/app_localizations.dart';
import '../home/home_route.dart';
import 'bloc/login_cubit.dart';
import 'bloc/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    final l10n = AppLocalizations.of(context)!;
    final dimens = AppDimensions.of(context);
    return Scaffold(
      // Keep this true
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: ResponsiveCenter(
          maxWidth: 460,
          padding: EdgeInsets.all(dimens.screenPadding),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Change to start
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Push the content down without pinning it to the very top.
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                _BrandHero(iconSize: dimens.heroIconSize),
                const SizedBox(height: AppSpacing.xl),
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
                    color: AppColors.white.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),
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
                const SizedBox(height: AppSpacing.lg),
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state.loginApiState is LoginSuccessful) {
                      context.go(HomeRoute.route);
                    }

                    if (state.loginApiState is LoginFailed) {
                      final errorMessage =
                          (state.loginApiState as LoginFailed).message;
                      Fluttertoast.showToast(msg: errorMessage);
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
                          foregroundColor: AppColors.white,
                          disabledBackgroundColor:
                              AppColors.blue500.withValues(alpha: 0.5),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppRadius.md),
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.4,
                                  valueColor: AlwaysStoppedAnimation(
                                    AppColors.white,
                                  ),
                                ),
                              )
                            : Text(l10n.login),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
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
    final muted = AppColors.white.withValues(alpha: 0.5);
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
        fillColor: AppColors.white.withValues(alpha: 0.045),
        border: border(AppColors.white.withValues(alpha: 0.07)),
        enabledBorder: border(AppColors.white.withValues(alpha: 0.07)),
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
                    color: AppColors.white.withValues(alpha: 0.8),
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
