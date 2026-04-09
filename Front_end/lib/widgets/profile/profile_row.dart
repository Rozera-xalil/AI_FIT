import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class ProfileRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget? trailing;
  final bool showDivider;
  const ProfileRow(
      {required this.icon, required this.label,
      this.trailing, this.showDivider = true});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(children: [
          trailing ?? const Icon(Icons.chevron_left_rounded,
              color: C.textMuted, size: 18),
          const Spacer(),
          Text(label,
              style: const TextStyle(
                  fontFamily: 'Rajdhani',
                  fontSize: 14, color: C.textPrim,
                  fontWeight: FontWeight.w600)),
          const SizedBox(width: 12),
          Container(
            width: 34, height: 34,
            decoration: BoxDecoration(
                color: C.bgSurface,
                borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: C.textSec, size: 17),
          ),
        ]),
      ),
      if (showDivider) Divider(color: C.border.withOpacity(0.5), height: 1),
    ]);
  }
}