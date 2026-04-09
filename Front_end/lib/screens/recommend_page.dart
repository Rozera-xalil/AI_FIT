import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../controllers/lang_controller.dart';
import '../controllers/recom_controller.dart';
import '../painters/grid_painter.dart';
import '../widgets/common/card_widget.dart';
import '../widgets/common/primary_button.dart';
import '../widgets/recommendation/gender_button.dart';
import '../widgets/recommendation/level_button.dart';
import '../widgets/recommendation/metric_field.dart';
import '../widgets/recommendation/result_card.dart';
import '../widgets/recommendation/workout_grid.dart';

class RecommendPage extends StatefulWidget {
  const RecommendPage({super.key});
  @override
  State<RecommendPage> createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _resultCtrl;
  late Animation<double> _resultFade;
  late Animation<Offset> _resultSlide;
  final ctrl = Get.find<RecomController>();

  final _ageCtrl = TextEditingController(text: '25');
  final _weightCtrl = TextEditingController(text: '70');
  final _heightCtrl = TextEditingController(text: '170');

  @override
  void initState() {
    super.initState();
    _resultCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _resultFade = CurvedAnimation(parent: _resultCtrl, curve: Curves.easeOut);
    _resultSlide = Tween<Offset>(
            begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(CurvedAnimation(parent: _resultCtrl, curve: Curves.easeOut));

    ever(ctrl.result, (_) {
      if (ctrl.result.value.isNotEmpty) _resultCtrl.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _resultCtrl.dispose();
    _ageCtrl.dispose();
    _weightCtrl.dispose();
    _heightCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: C.bg,
      body: Stack(children: [
        // تم التصحيح هنا: استخدم GridPainter() بدلاً من _GridPainter()
        CustomPaint(painter: GridPainter(), size: size),
        CustomScrollView(slivers: [
          GetBuilder<LangController>(
            builder: (_) => _PageAppBar(title: 'nav_workout'.tr),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                CardWidget(child: GetBuilder<LangController>(
                  builder: (_) => Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _CardLabel('personal_data'.tr),
                      const SizedBox(height: 16),
                      Row(children: [
                        Obx(() => GenderButton(
                            label: 'female'.tr, emoji: '👩',
                            active: ctrl.gender.value == 0,
                            onTap: () => ctrl.gender.value = 0)),
                        const SizedBox(width: 10),
                        Obx(() => GenderButton(
                            label: 'male'.tr, emoji: '👨',
                            active: ctrl.gender.value == 1,
                            onTap: () => ctrl.gender.value = 1)),
                      ]),
                      const SizedBox(height: 16),
                      Row(children: [
                        Expanded(child: MetricField(
                            ctrl: _ageCtrl,
                            label: 'age'.tr, unit: 'years'.tr,
                            onChanged: (v) => ctrl.age.value =
                                double.tryParse(v) ?? ctrl.age.value)),
                        const SizedBox(width: 10),
                        Expanded(child: MetricField(
                            ctrl: _weightCtrl,
                            label: 'weight'.tr, unit: 'kg'.tr,
                            onChanged: (v) => ctrl.weight.value =
                                double.tryParse(v) ?? ctrl.weight.value)),
                        const SizedBox(width: 10),
                        Expanded(child: MetricField(
                            ctrl: _heightCtrl,
                            label: 'height'.tr, unit: 'cm'.tr,
                            onChanged: (v) => ctrl.height.value =
                                double.tryParse(v) ?? ctrl.height.value)),
                      ]),
                      const SizedBox(height: 16),
                      _CardLabel('exp_level'.tr),
                      const SizedBox(height: 10),
                      Row(children: [
                        LevelButton(label: 'beginner'.tr, val: 1),
                        const SizedBox(width: 8),
                        LevelButton(label: 'intermediate'.tr, val: 2),
                        const SizedBox(width: 8),
                        LevelButton(label: 'advanced'.tr, val: 3),
                      ]),
                    ],
                  ),
                )),
                const SizedBox(height: 16),
                Obx(() => PrimaryButton(
                  loading: ctrl.loading.value,
                  onTap: ctrl.loading.value ? null : () {
                    FocusScope.of(context).unfocus();
                    ctrl.getRecommendation();
                  },
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.auto_awesome_rounded,
                        color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    GetBuilder<LangController>(
                      builder: (_) => Text('get_recom'.tr,
                          style: const TextStyle(
                              fontFamily: 'Rajdhani',
                              fontSize: 16, fontWeight: FontWeight.w700,
                              color: Colors.white)),
                    ),
                  ]),
                )),
                const SizedBox(height: 20),
                Obx(() {
                  if (ctrl.result.value.isEmpty) return const SizedBox.shrink();
                  return FadeTransition(
                    opacity: _resultFade,
                    child: SlideTransition(
                      position: _resultSlide,
                      child: ResultCard(
                        workout: ctrl.result.value,
                        confidence: ctrl.confidence.value,
                        scores: Map<String, double>.from(ctrl.scores),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 20),
                const Text('Werzîşên Hevpar',
                    style: TextStyle(
                        fontFamily: 'Rajdhani',
                        fontSize: 16, fontWeight: FontWeight.w700,
                        color: C.textPrim)),
                const SizedBox(height: 12),
                 WorkoutGrid(),
                const SizedBox(height: 24),
              ]),
            ),
          ),
        ]),
      ]),
    );
  }
}

class _PageAppBar extends StatelessWidget {
  final String title;
  const _PageAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: C.bg,
      pinned: true, elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 34, height: 34,
            decoration: BoxDecoration(
              color: C.bgSurface, borderRadius: BorderRadius.circular(10),
              border: Border.all(color: C.border)),
            child: const Icon(Icons.more_horiz_rounded,
                color: C.textSec, size: 16),
          ),
          ShaderMask(
            shaderCallback: (b) => C.gradPrimary.createShader(b),
            child: Text(title,
                style: const TextStyle(
                    fontFamily: 'Rajdhani',
                    fontSize: 18, fontWeight: FontWeight.w700,
                    color: Colors.white)),
          ),
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(
              gradient: C.gradPrimary,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(
                  color: C.purple.withOpacity(0.4),
                  blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('KRD',
                    style: TextStyle(
                        fontFamily: 'Rajdhani',
                        fontSize: 7, fontWeight: FontWeight.w700,
                        color: Colors.white, letterSpacing: 1)),
                Text('FIT',
                    style: TextStyle(
                        fontFamily: 'Rajdhani',
                        fontSize: 4, fontWeight: FontWeight.w400,
                        color: Color(0xFFE9D5FF),
                        letterSpacing: 1)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CardLabel extends StatelessWidget {
  final String text;
  const _CardLabel(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
            fontFamily: 'Rajdhani',
            fontSize: 11, fontWeight: FontWeight.w600,
            color: C.textMuted, letterSpacing: 1));
  }
}