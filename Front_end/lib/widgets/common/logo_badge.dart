import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class LogoBadge extends StatelessWidget {
  final double size;
  const LogoBadge({this.size = 44});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(
        gradient: C.gradPrimary,
        borderRadius: BorderRadius.circular(size * 0.28),
        boxShadow: [BoxShadow(
            color: C.purple.withOpacity(0.4),
            blurRadius: 12, offset: const Offset(0, 3))],
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('KRD',
            style: TextStyle(
                fontFamily: 'Rajdhani',
                fontSize: size * 0.22, fontWeight: FontWeight.w700,
                color: Colors.white, letterSpacing: 1)),
        Text('FIT',
            style: TextStyle(
                fontFamily: 'Rajdhani',
                fontSize: size * 0.12,
                color: const Color(0xFFE9D5FF),
                letterSpacing: 2)),
      ]),
    );
  }
}