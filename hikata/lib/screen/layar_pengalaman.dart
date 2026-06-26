import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({super.key});

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  int _rating = 5;
  final _commentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _lastComment = '';
  int _lastRating = 0;
  bool _hasLastReview = false;
  String _selectedTag = '';

  @override
  void initState() {
    super.initState();
    _loadLastReview();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _loadLastReview() async {
    final defaultTag = context.t.feedback.tags.fun;
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _lastRating = prefs.getInt('review_rating') ?? 0;
      _lastComment = prefs.getString('review_comment') ?? '';
      _selectedTag = prefs.getString('review_tag') ?? defaultTag;
      _hasLastReview = _lastRating > 0;
    });
  }

  Future<void> _submitReview() async {
    if (!_formKey.currentState!.validate()) return;
    HapticFeedback.mediumImpact();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('review_rating', _rating);
    await prefs.setString('review_comment', _commentController.text);
    await prefs.setString('review_tag', _selectedTag);

    setState(() {
      _lastRating = _rating;
      _lastComment = _commentController.text;
      _hasLastReview = true;
      _commentController.clear();
    });

    if (mounted) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Text(
            context.t.feedback.thanks,
            style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
          ),
          content: Text(
            context.t.feedback.thanksBody,
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AppColors.primaryGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  String _ratingLabel() {
    final r = context.t.feedback.ratings;
    switch (_rating) {
      case 1: return r.veryBad;
      case 2: return r.notSatisfied;
      case 3: return r.okay;
      case 4: return r.satisfied;
      default: return r.outstanding;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = context.hiKata;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: colors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // ── Header ──
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 38, height: 38,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.15),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded,
                            color: Colors.white, size: 16),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      context.t.feedback.title,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20, fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── Content ──
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colors.cardBackground,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Intro banner
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.primaryGreen.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.primaryGreen.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Text('💬', style: TextStyle(fontSize: 28)),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    context.t.feedback.intro,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      height: 1.5,
                                      color: isDark ? colors.textPrimary : AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 28),

                          // Rating section
                          Text(
                            context.t.feedback.rateUs,
                            style: TextStyle(
                              fontFamily: 'Poppins', fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isDark ? colors.textPrimary : AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),

                          Center(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(5, (index) {
                                    final val = index + 1;
                                    final filled = val <= _rating;
                                    return GestureDetector(
                                      onTap: () {
                                        HapticFeedback.selectionClick();
                                        setState(() => _rating = val);
                                      },
                                      child: AnimatedScale(
                                        scale: filled ? 1.15 : 1.0,
                                        duration: const Duration(milliseconds: 150),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 4),
                                          child: Icon(
                                            filled ? Icons.star_rounded : Icons.star_outline_rounded,
                                            color: filled ? const Color(0xFFFFB300) : colors.divider,
                                            size: 42,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                                const SizedBox(height: 8),
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 200),
                                  child: Text(
                                    _ratingLabel(),
                                    key: ValueKey(_rating),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryGreen,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 28),

                          // Impression tags
                          Text(
                            context.t.feedback.firstImpression,
                            style: TextStyle(
                              fontFamily: 'Poppins', fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isDark ? colors.textPrimary : AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8, runSpacing: 8,
                            children: [
                              context.t.feedback.tags.fun,
                              context.t.feedback.tags.easy,
                              context.t.feedback.tags.helpful,
                              context.t.feedback.tags.improve,
                            ].map((tag) {
                              final isSelected = tag == _selectedTag;
                              return GestureDetector(
                                onTap: () {
                                  HapticFeedback.selectionClick();
                                  setState(() => _selectedTag = tag);
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.primaryGreen
                                        : (isDark ? colors.fieldFill : Colors.grey.shade100),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primaryGreen
                                          : (isDark ? colors.divider : Colors.grey.shade300),
                                    ),
                                  ),
                                  child: Text(
                                    tag,
                                    style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected
                                          ? Colors.white
                                          : (isDark ? colors.textMuted : Colors.grey.shade600),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          const SizedBox(height: 28),

                          // Comment field
                          Text(
                            context.t.feedback.writeSuggestions,
                            style: TextStyle(
                              fontFamily: 'Poppins', fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isDark ? colors.textPrimary : AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _commentController,
                            maxLines: 4, maxLength: 150,
                            style: TextStyle(
                              fontFamily: 'Poppins', fontSize: 13,
                              color: isDark ? colors.textPrimary : AppColors.textPrimary,
                            ),
                            decoration: InputDecoration(
                              hintText: context.t.feedback.commentHint,
                              hintStyle: TextStyle(
                                fontFamily: 'Poppins', fontSize: 13,
                                color: colors.textMuted,
                              ),
                              filled: true,
                              fillColor: isDark ? colors.fieldFill : Colors.grey.shade50,
                              contentPadding: const EdgeInsets.all(16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: isDark ? colors.divider : Colors.grey.shade200,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: AppColors.primaryGreen, width: 1.5,
                                ),
                              ),
                            ),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return context.t.feedback.commentEmpty;
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 20),

                          // Submit button
                          _SubmitButton(
                            label: context.t.feedback.submit,
                            onTap: _submitReview,
                          ),

                          // Last review
                          if (_hasLastReview) ...[
                            const SizedBox(height: 32),
                            Divider(color: colors.divider),
                            const SizedBox(height: 20),
                            Text(
                              context.t.feedback.lastReview,
                              style: TextStyle(
                                fontFamily: 'Poppins', fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: isDark ? colors.textPrimary : AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: AppColors.primaryGreen.withValues(alpha: 0.06),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: AppColors.primaryGreen.withValues(alpha: 0.2),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: List.generate(5, (i) => Icon(
                                          i < _lastRating ? Icons.star_rounded : Icons.star_border_rounded,
                                          color: const Color(0xFFFFB300),
                                          size: 18,
                                        )),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryGreen.withValues(alpha: 0.12),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          _selectedTag,
                                          style: TextStyle(
                                            fontFamily: 'Poppins', fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primaryGreen,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (_lastComment.isNotEmpty) ...[
                                    const SizedBox(height: 10),
                                    Text(
                                      _lastComment,
                                      style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 12.5,
                                        height: 1.5,
                                        color: isDark ? colors.textMuted : Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Submit Button ──────────────────────────────────────────────────────────

class _SubmitButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _SubmitButton({required this.label, required this.onTap});

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    _scale = Tween<double>(begin: 1.0, end: 0.96)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: GestureDetector(
        onTapDown: (_) => _ctrl.forward(),
        onTapUp: (_) { _ctrl.reverse(); widget.onTap(); },
        onTapCancel: () => _ctrl.reverse(),
        child: Container(
          width: double.infinity, height: 52,
          decoration: BoxDecoration(
            gradient: AppColors.buttonGradient,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryGreen.withValues(alpha: 0.35),
                blurRadius: 12, offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.label,
              style: AppTextStyles.buttonText.copyWith(fontSize: 14, letterSpacing: 1.2),
            ),
          ),
        ),
      ),
    );
  }
}
