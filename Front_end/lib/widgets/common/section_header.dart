import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class SectionHeader extends StatelessWidget {
  final String title, action;
  const SectionHeader({required this.title, required this.action});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (action.isNotEmpty)
          ShaderMask(
            shaderCallback: (b) => C.gradPrimary.createShader(b),
            child: Text(action,
                style: const TextStyle(
                    fontFamily: 'Rajdhani',
                    fontSize: 13, fontWeight: FontWeight.w700,
                    color: Colors.white))),
        Text(title,
            style: const TextStyle(
                fontFamily: 'Rajdhani',
                fontSize: 16, fontWeight: FontWeight.w700,
                color: C.textPrim, letterSpacing: -0.2)),
      ],
    );
  }
}