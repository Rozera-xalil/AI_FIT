import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class AuthTab extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const AuthTab(
      {required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: active ? C.gradPrimary : null,
            borderRadius: BorderRadius.circular(11),
            boxShadow: active
                ? [BoxShadow(
                    color: C.purple.withOpacity(0.3), blurRadius: 10)]
                : [],
          ),
          child: Center(
            child: Text(label,
                style: TextStyle(
                    fontFamily: 'Rajdhani',
                    fontSize: 14, fontWeight: FontWeight.w700,
                    color: active ? Colors.white : C.textSec)),
          ),
        ),
      ),
    );
  }
}