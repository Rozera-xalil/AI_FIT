import 'package:flutter/material.dart';

class C {
  static const bg        = Color(0xFF0E0B16);
  static const bgCard    = Color(0xFF16112A);
  static const bgSurface = Color(0xFF1E1836);
  static const bgInput   = Color(0xFF12102A);

  static const purple    = Color(0xFF8B5CF6);
  static const purpleL   = Color(0xFFA78BFA);
  static const purpleD   = Color(0xFF6D28D9);

  static const gold      = Color(0xFFD97706);
  static const goldL     = Color(0xFFFBBF24);

  static const success   = Color(0xFF10B981);
  static const danger    = Color(0xFFEF4444);

  static const textPrim  = Color(0xFFF3F0FF);
  static const textSec   = Color(0xFF9B8EC4);
  static const textMuted = Color(0xFF4B4272);

  static const border    = Color(0xFF2D2450);

  static const gradPrimary = LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
    begin: Alignment.topLeft, end: Alignment.bottomRight,
  );
  static const gradGold = LinearGradient(
    colors: [Color(0xFFFBBF24), Color(0xFFD97706)],
    begin: Alignment.topLeft, end: Alignment.bottomRight,
  );
  static const gradCard = LinearGradient(
    colors: [Color(0xFF16112A), Color(0xFF110E22)],
    begin: Alignment.topLeft, end: Alignment.bottomRight,
  );
  static const gradHero = LinearGradient(
    colors: [Color(0xFF1E1836), Color(0xFF16112A), Color(0xFF0E0B16)],
    begin: Alignment.topCenter, end: Alignment.bottomCenter,
  );
}