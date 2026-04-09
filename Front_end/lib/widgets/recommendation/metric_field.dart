import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class MetricField extends StatelessWidget {
  final TextEditingController ctrl;
  final String label, unit;
  final Function(String) onChanged;
  const MetricField(
      {required this.ctrl, required this.label,
      required this.unit, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Text(label,
          style: const TextStyle(
              fontFamily: 'Rajdhani',
              fontSize: 10, color: C.textSec,
              fontWeight: FontWeight.w600, letterSpacing: 0.5)),
      const SizedBox(height: 6),
      Container(
        decoration: BoxDecoration(
          color: C.bgInput,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: C.border),
        ),
        child: Row(children: [
          Expanded(
            child: TextField(
              controller: ctrl,
              onChanged: onChanged,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: 'Rajdhani',
                  color: C.textPrim, fontSize: 15,
                  fontWeight: FontWeight.w700),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Text(unit,
                style: const TextStyle(
                    fontFamily: 'Rajdhani',
                    fontSize: 9, color: C.textMuted))),
        ]),
      ),
    ]);
  }
}