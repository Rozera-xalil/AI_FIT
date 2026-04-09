import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import 'spinner_widget.dart';

class PrimaryButton extends StatelessWidget {
  final bool loading;
  final VoidCallback? onTap;
  final Widget child;
  const PrimaryButton(
      {this.loading = false, this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity, height: 56,
        decoration: BoxDecoration(
          gradient: loading ? null : C.gradPrimary,
          color: loading ? C.bgSurface : null,
          borderRadius: BorderRadius.circular(16),
          border: loading ? Border.all(color: C.border) : null,
          boxShadow: loading
              ? []
              : [
                  BoxShadow(
                      color: C.purple.withOpacity(0.4),
                      blurRadius: 20, offset: const Offset(0, 8)),
                ],
        ),
        child: Center(child: loading ? const SpinnerWidget() : child),
      ),
    );
  }
}