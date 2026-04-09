import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class GenderButton extends StatelessWidget {
  final String label, emoji;
  final bool active;
  final VoidCallback onTap;
  const GenderButton(
      {required this.label, required this.emoji,
      required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            gradient: active ? C.gradPrimary : null,
            color: active ? null : C.bgSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: active ? Colors.transparent : C.border, width: 1),
            boxShadow: active
                ? [BoxShadow(
                    color: C.purple.withOpacity(0.3), blurRadius: 12)]
                : [],
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(emoji, style: const TextStyle(fontSize: 17)),
            const SizedBox(width: 7),
            Text(label,
                style: TextStyle(
                    fontFamily: 'Rajdhani',
                    fontSize: 14, fontWeight: FontWeight.w700,
                    color: active ? Colors.white : C.textSec)),
          ]),
        ),
      ),
    );
  }
}