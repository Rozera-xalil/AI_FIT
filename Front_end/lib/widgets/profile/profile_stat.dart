import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class ProfileStat extends StatelessWidget {
  final String value, label;
  const ProfileStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ShaderMask(
        shaderCallback: (b) => C.gradPrimary.createShader(b),
        child: Text(value,
            style: const TextStyle(
                fontFamily: 'Rajdhani',
                fontSize: 22, fontWeight: FontWeight.w700,
                color: Colors.white)),
      ),
      Text(label,
          style: const TextStyle(
              fontFamily: 'Rajdhani', fontSize: 10, color: C.textSec)),
    ]);
  }
}