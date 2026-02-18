import 'package:flutter/material.dart';

class UsersManagementPaginationView extends StatelessWidget {
  const UsersManagementPaginationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: const [
        UsersManagementPageButton(icon: Icons.chevron_left_rounded),
        UsersManagementPageButton(label: '1', selected: true),
        UsersManagementPageButton(label: '2'),
        UsersManagementPageButton(label: '3'),
        UsersManagementPageButton(label: '4'),
        UsersManagementPageButton(icon: Icons.chevron_right_rounded),
      ],
    );
  }
}

class UsersManagementPageButton extends StatelessWidget {
  const UsersManagementPageButton({
    super.key,
    this.label,
    this.icon,
    this.selected = false,
    this.onPressed,
  });

  final String? label;
  final IconData? icon;
  final bool selected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onPressed,
        child: Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF1A1A1A) : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected
                  ? const Color(0xFF1A1A1A)
                  : const Color(0xFFEAEAEA),
            ),
          ),
          child: icon != null
              ? Icon(
                  icon,
                  size: 18,
                  color: selected ? Colors.white : const Color(0xFF666666),
                )
              : Text(
                  label!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: selected ? Colors.white : const Color(0xFF666666),
                  ),
                ),
        ),
      ),
    );
  }
}
