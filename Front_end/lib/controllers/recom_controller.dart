import 'dart:math';
import 'package:get/get.dart';

class RecomController extends GetxController {
  final age = 25.0.obs;
  final weight = 70.0.obs;
  final height = 170.0.obs;
  final gender = 1.obs;
  final experience = 1.obs;
  final result = ''.obs;
  final confidence = 0.0.obs;
  final scores = <String, double>{}.obs;
  final loading = false.obs;

  String _predict() {
    final hM = height.value / 100;
    final bmi = weight.value / (hM * hM);
    if (bmi > 30) return 'cardio'.tr;
    if (bmi < 19) return 'strength'.tr;
    if (experience.value == 3) return 'hiit'.tr;
    if (gender.value == 0) return 'yoga'.tr;
    return 'strength'.tr;
  }

  Map<String, double> _buildScores(String pred) {
    final types = ['cardio'.tr, 'strength'.tr, 'hiit'.tr, 'yoga'.tr];
    final rnd = Random();
    double rem = 1.0;
    final sc = <String, double>{};
    for (final t in types) {
      if (t == pred) continue;
      final v = (rnd.nextDouble() * rem * 0.4).clamp(0.05, 0.30);
      sc[t] = double.parse(v.toStringAsFixed(2));
      rem -= v;
    }
    sc[pred] = double.parse(rem.clamp(0.3, 0.8).toStringAsFixed(2));
    return sc;
  }

  Future<void> getRecommendation() async {
    loading.value = true;
    result.value = '';
    await Future.delayed(const Duration(milliseconds: 1100));
    final pred = _predict();
    final sc = _buildScores(pred);
    result.value = pred;
    confidence.value = sc[pred]! * 100;
    scores.value = sc;
    loading.value = false;
  }
}