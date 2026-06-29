import 'package:flutter/material.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

/// Tombol gradien dengan animasi tekan (scale). Dipakai di layar auth
/// (masuk, daftar, reset sandi).
class TombolGradient extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final double height;

  const TombolGradient({
    super.key,
    required this.label,
    required this.onPressed,
    this.height = 48,
  });

  @override
  State<TombolGradient> createState() => _TombolGradientState();
}

class _TombolGradientState extends State<TombolGradient>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnim = Tween<double>(
      begin: 1,
      end: 0.97,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnim,
      child: GestureDetector(
        onTapDown: (_) => _ctrl.forward(),
        onTapUp: (_) {
          _ctrl.reverse();
          widget.onPressed();
        },
        onTapCancel: () => _ctrl.reverse(),
        child: Container(
          width: double.infinity,
          height: widget.height,
          decoration: AppDecorations.gradientButton,
          child: Center(
            child: Text(widget.label, style: AppTextStyles.buttonText),
          ),
        ),
      ),
    );
  }
}
