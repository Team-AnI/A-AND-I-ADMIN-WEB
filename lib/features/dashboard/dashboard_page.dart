import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../auth/presentation/bloc/auth_bloc.dart';
import '../auth/presentation/bloc/auth_event.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          TextButton(
            onPressed: () {
              ref
                  .read(authBlocProvider.notifier)
                  .onEvent(const AuthLogoutRequested());
              context.go('/login');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
      body: const Center(child: Text('Dashboard')),
    );
  }
}
