import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class ResultCard extends StatelessWidget {
  final String workout;
  final double confidence;
  final Map<String, double> scores;
  const ResultCard(
      {required this.workout,
      required this.confidence,
      required this.scores});

  String _emoji() {
    if (workout.contains('HIIT')) return '🔥';
    if (workout.contains('Hêz') ||
        workout.contains('Strength') ||
        workout.contains('Force')) return '💪';
    if (workout.contains('Kardîyo') || workout.contains('Cardio')) return '🏃';
    return '🧘';
  }

  Color _color() {
    if (workout.contains('HIIT')) return const Color(0xFFEF4444);
    if (workout.contains('Hêz') ||
        workout.contains('Strength') ||
        workout.contains('Force')) return C.purple;
    if (workout.contains('Kardîyo') || workout.contains('Cardio')) return C.success;
    return C.gold;
  }

  @override
  Widget build(BuildContext context) {
    final col = _color();
    final sorted = scores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: C.bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: col.withOpacity(0.5), width: 1.5),
        boxShadow: [
          BoxShadow(
              color: col.withOpacity(0.18), blurRadius: 30, spreadRadius: 2),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Row(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: col.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: col.withOpacity(0.3)),
            ),
            child: Text('${confidence.toStringAsFixed(0)}%',
                style: TextStyle(
                    fontFamily: 'Rajdhani',
                    fontSize: 14, fontWeight: FontWeight.w700, color: col)),
          ),
          const Spacer(),
          Container(
            width: 58, height: 58,
            decoration: BoxDecoration(
              color: col.withOpacity(0.12),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: col.withOpacity(0.3)),
            ),
            child: Center(
                child: Text(_emoji(),
                    style: const TextStyle(fontSize: 28))),
          ),
          const SizedBox(width: 14),
          Flexible(
            child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(workout,
                  style: TextStyle(
                      fontFamily: 'Rajdhani',
                      fontSize: 22, fontWeight: FontWeight.w700,
                      color: col, letterSpacing: -0.3,
                      shadows: [Shadow(
                          color: col.withOpacity(0.4), blurRadius: 8)])),
              const Text('your_recom',
                  style: TextStyle(
                      fontFamily: 'Rajdhani',
                      fontSize: 11, color: C.textSec)),
            ]),
          ),
        ]),
        const SizedBox(height: 20),
        const Text('comparing',
            style: TextStyle(
                fontFamily: 'Rajdhani',
                fontSize: 11, color: C.textSec,
                fontWeight: FontWeight.w600, letterSpacing: 0.5)),
        const SizedBox(height: 12),
        ...sorted.map((e) => _ScoreRow(
            label: e.key, value: e.value,
            color: col, isTop: e.key == workout)),
      ]),
    );
  }
}

class _ScoreRow extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  final bool isTop;
  const _ScoreRow(
      {required this.label, required this.value,
      required this.color, required this.isTop});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(children: [
        Text('${(value * 100).toStringAsFixed(0)}%',
            style: TextStyle(
                fontFamily: 'Rajdhani',
                fontSize: 11,
                color: isTop ? color : C.textMuted)),
        const SizedBox(width: 10),
        Expanded(child: Stack(children: [
          Container(
              height: 5,
              decoration: BoxDecoration(
                  color: C.border, borderRadius: BorderRadius.circular(3))),
          FractionallySizedBox(
            widthFactor: value,
            child: Container(
                height: 5,
                decoration: BoxDecoration(
                  gradient: isTop
                      ? LinearGradient(
                          colors: [color, color.withOpacity(0.5)])
                      : null,
                  color: isTop ? null : C.border.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: isTop
                      ? [BoxShadow(
                          color: color.withOpacity(0.4), blurRadius: 4)]
                      : [],
                )),
          ),
        ])),
        const SizedBox(width: 10),
        SizedBox(
          width: 70,
          child: Text(label,
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontFamily: 'Rajdhani',
                  fontSize: 11,
                  color: isTop ? color : C.textSec,
                  fontWeight:
                      isTop ? FontWeight.w700 : FontWeight.w400)),
        ),
      ]),
    );
  }
}