import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aandi_auth/aandi_auth.dart';

import 'domain/entities/admin_user_provision_type.dart';
import 'models/users_management_user_row.dart';
import 'presentation/bloc/users_management_bloc.dart';
import 'presentation/bloc/users_management_event.dart';
import 'presentation/bloc/users_management_state.dart';
import 'views/users_management_pagination_view.dart';
import 'views/users_management_table_view.dart';

class UsersManagementView extends ConsumerStatefulWidget {
  const UsersManagementView({
    super.key,
    required this.showLogoutButton,
    this.onLogout,
  });

  final bool showLogoutButton;
  final VoidCallback? onLogout;

  @override
  ConsumerState<UsersManagementView> createState() =>
      _UsersManagementViewState();
}

class _UsersManagementViewState extends ConsumerState<UsersManagementView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(usersManagementBlocProvider.notifier)
          .onEvent(const UsersManagementStarted());
    });
  }

  Future<void> _onCreateUserPressed() async {
    final formData = await _showCreateUserDialog(context);
    if (formData == null || !mounted) {
      return;
    }

    await ref
        .read(usersManagementBlocProvider.notifier)
        .onEvent(
          UsersManagementCreateRequested(
            role: formData.role,
            provisionType: formData.provisionType,
          ),
        );
    if (!mounted) return;

    final nextState = ref.read(usersManagementBlocProvider);
    final isSuccess =
        nextState.status == UsersManagementStatus.success &&
        nextState.errorMessage == null;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isSuccess
              ? '사용자가 생성되었습니다.'
              : (nextState.errorMessage ?? '사용자 생성에 실패했습니다.'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(usersManagementBlocProvider);
    final rows = state.users
        .map(
          (user) => UsersManagementUserRow(
            user.username,
            user.username,
            switch (user.role) {
              AuthRole.admin => '관리자',
              AuthRole.organizer => '멘토',
              AuthRole.user => '일반',
            },
          ),
        )
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final searchWidth = constraints.maxWidth;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '사용자 관리',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.8,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '플랫폼의 모든 사용자 계정을 관리하고 권한을 설정합니다.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF8A8A8A),
                ),
              ),
              const SizedBox(height: 32),
              Wrap(
                runSpacing: 12,
                spacing: 12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SizedBox(
                    width: searchWidth,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '닉네임 또는 아이디로 사용자 검색...',
                        prefixIcon: const Icon(Icons.search_rounded),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFEAEAEA),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFEAEAEA),
                          ),
                        ),
                      ),
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: _onCreateUserPressed,
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF1A1A1A),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.add_rounded),
                    label: const Text(
                      '사용자 생성',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (state.status == UsersManagementStatus.loading)
                const SizedBox(
                  height: 220,
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state.status == UsersManagementStatus.failure)
                SizedBox(
                  height: 220,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(state.errorMessage ?? '사용자 목록을 불러오지 못했습니다.'),
                        const SizedBox(height: 8),
                        FilledButton(
                          onPressed: () {
                            ref
                                .read(usersManagementBlocProvider.notifier)
                                .onEvent(
                                  const UsersManagementRefreshRequested(),
                                );
                          },
                          child: const Text('다시 시도'),
                        ),
                      ],
                    ),
                  ),
                )
              else
                UsersManagementTableView(
                  users: rows,
                  minWidth: constraints.maxWidth,
                ),
              const SizedBox(height: 20),
              const Center(child: UsersManagementPaginationView()),
              const SizedBox(height: 48),
              const Divider(color: Color(0xFFF0F0F0)),
              const SizedBox(height: 18),
              const Center(
                child: Text(
                  '© 2026 A&I. All rights reserved.',
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFB0B0B0),
                  ),
                ),
              ),
              if (widget.showLogoutButton) ...[
                const SizedBox(height: 16),
                Center(
                  child: TextButton.icon(
                    onPressed: widget.onLogout,
                    icon: const Icon(Icons.logout_rounded, size: 18),
                    label: const Text('로그아웃'),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _CreateUserFormData {
  const _CreateUserFormData({required this.role, required this.provisionType});

  final AuthRole role;
  final AdminUserProvisionType provisionType;
}

Future<_CreateUserFormData?> _showCreateUserDialog(BuildContext context) {
  final formKey = GlobalKey<FormState>();
  AuthRole selectedRole = AuthRole.user;
  AdminUserProvisionType selectedProvisionType = AdminUserProvisionType.invite;

  return showDialog<_CreateUserFormData>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('사용자 생성'),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<AuthRole>(
                    initialValue: selectedRole,
                    decoration: const InputDecoration(labelText: '권한'),
                    items: const [
                      DropdownMenuItem(
                        value: AuthRole.user,
                        child: Text('일반(USER)'),
                      ),
                      DropdownMenuItem(
                        value: AuthRole.organizer,
                        child: Text('멘토(ORGANIZER)'),
                      ),
                      DropdownMenuItem(
                        value: AuthRole.admin,
                        child: Text('관리자(ADMIN)'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        selectedRole = value;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<AdminUserProvisionType>(
                    initialValue: selectedProvisionType,
                    decoration: const InputDecoration(labelText: '생성 방식'),
                    items: const [
                      DropdownMenuItem(
                        value: AdminUserProvisionType.invite,
                        child: Text('초대 링크(INVITE)'),
                      ),
                      DropdownMenuItem(
                        value: AdminUserProvisionType.password,
                        child: Text('임시 비밀번호(PASSWORD)'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        selectedProvisionType = value;
                      });
                    },
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('취소'),
          ),
          FilledButton(
            onPressed: () {
              if (!(formKey.currentState?.validate() ?? false)) {
                return;
              }
              Navigator.of(dialogContext).pop(
                _CreateUserFormData(
                  role: selectedRole,
                  provisionType: selectedProvisionType,
                ),
              );
            },
            child: const Text('생성'),
          ),
        ],
      );
    },
  );
}
