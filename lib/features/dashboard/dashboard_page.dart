import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../auth/presentation/bloc/auth_bloc.dart';
import '../auth/presentation/bloc/auth_event.dart';
import 'dashboard_nav_view_model.dart';
import 'views/dashboard_body_view.dart';
import 'views/dashboard_sidebar_view.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(dashboardNavViewModelProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 980;
        final body = DashboardBodyView(
          selectedTab: selectedTab,
          isDesktop: isDesktop,
          onLogout: () {
            ref
                .read(authBlocProvider.notifier)
                .onEvent(const AuthLogoutRequested());
            context.go('/login');
          },
        );

        if (isDesktop) {
          return Scaffold(
            backgroundColor: const Color(0xFFFCFCFC),
            body: Row(
              children: [
                const DashboardSidebarView(),
                Expanded(child: body),
              ],
            ),
          );
        }

        return Scaffold(
          backgroundColor: const Color(0xFFFCFCFC),
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            title: const Text(
              'A&I Admin',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  ref
                      .read(authBlocProvider.notifier)
                      .onEvent(const AuthLogoutRequested());
                  context.go('/login');
                },
                icon: const Icon(Icons.logout_rounded),
              ),
            ],
          ),
          body: body,
        );
      },
    );
  }
}
