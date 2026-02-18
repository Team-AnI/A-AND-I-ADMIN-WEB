import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../auth/presentation/bloc/auth_bloc.dart';
import '../auth/presentation/bloc/auth_event.dart';
import 'presentation/bloc/login_bloc.dart';
import 'presentation/bloc/login_event.dart';
import 'presentation/bloc/login_state.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final bloc = ref.read(loginBlocProvider.notifier);
    await bloc.onEvent(const LoginSubmitted());
    final state = ref.read(loginBlocProvider);
    if (state.submissionStatus == LoginSubmissionStatus.success) {
      if (!mounted) return;
      ref.read(authBlocProvider.notifier).onEvent(const AuthLoginSucceeded());
      context.go('/dashboard');
      bloc.onEvent(const LoginSubmissionReset());
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginBlocProvider);

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Card(
            margin: const EdgeInsets.all(24),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Admin Login',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _idController,
                      decoration: const InputDecoration(labelText: 'Username'),
                      onChanged: (value) {
                        ref
                            .read(loginBlocProvider.notifier)
                            .onEvent(LoginUsernameChanged(value));
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Username is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Password'),
                      onChanged: (value) {
                        ref
                            .read(loginBlocProvider.notifier)
                            .onEvent(LoginPasswordChanged(value));
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    if (state.errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          state.errorMessage!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ElevatedButton(
                      onPressed:
                          state.canSubmit &&
                              state.submissionStatus !=
                                  LoginSubmissionStatus.submitting
                          ? _submit
                          : null,
                      child:
                          state.submissionStatus ==
                              LoginSubmissionStatus.submitting
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Login'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
