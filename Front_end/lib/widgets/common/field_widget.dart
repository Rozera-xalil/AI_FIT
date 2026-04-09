import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class FieldWidget extends StatelessWidget {
  final TextEditingController ctrl;
  final String hint;
  final IconData icon;
  final bool obscure;
  final TextInputType? type;
  final Widget? suffix;
  const FieldWidget(
      {required this.ctrl, required this.hint, required this.icon,
      this.obscure = false, this.type, this.suffix});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: C.bgInput,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: C.border),
      ),
      child: TextField(
        controller: ctrl,
        obscureText: obscure,
        keyboardType: type,
        style: const TextStyle(
            fontFamily: 'Rajdhani', color: C.textPrim, fontSize: 15),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
              fontFamily: 'Rajdhani', color: C.textMuted, fontSize: 14),
          prefixIcon: Icon(icon, color: C.textSec, size: 20),
          suffixIcon: suffix,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }
}