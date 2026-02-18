import 'package:flutter/material.dart';

import '../models/users_management_user_row.dart';

class UsersManagementTableView extends StatelessWidget {
  const UsersManagementTableView({
    super.key,
    required this.users,
    required this.minWidth,
  });

  final List<UsersManagementUserRow> users;
  final double minWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFEAEAEA)),
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: minWidth),
          child: DataTable(
            headingTextStyle: const TextStyle(
              color: Color(0xFF888888),
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
            dataTextStyle: const TextStyle(
              color: Color(0xFF1A1A1A),
              fontWeight: FontWeight.w600,
            ),
            columns: const [
              DataColumn(label: Text('닉네임')),
              DataColumn(label: Text('아이디')),
              DataColumn(label: Text('권한')),
              DataColumn(label: Text('관리')),
            ],
            rows: users
                .map(
                  (user) => DataRow(
                    cells: [
                      DataCell(Text(user.name)),
                      DataCell(
                        Text(
                          user.username,
                          style: const TextStyle(
                            color: Color(0xFF767676),
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: user.role == '관리자'
                                ? const Color(0xFF1A1A1A)
                                : const Color(0xFFF4F4F4),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            user.role,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: user.role == '관리자'
                                  ? Colors.white
                                  : const Color(0xFF1A1A1A),
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        TextButton(onPressed: () {}, child: const Text('수정')),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
