import 'package:flutter/material.dart';
import 'package:ppkd_b6/screen/pengenalan/pilih_bahasa.dart';
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
  String _selectedTag = 'Menyenangkan';

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

  bool get _isID => AppLanguage.current == 'id';

  List<String> get _tags => _isID
      ? [
          'Menyenangkan',
          'Mudah Dipahami',
          'Sangat Membantu',
          'Perlu Peningkatan',
        ]
      : ['Fun', 'Easy to Understand', 'Very Helpful', 'Needs Improvement'];

  Future<void> _loadLastReview() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastRating = prefs.getInt('review_rating') ?? 0;
      _lastComment = prefs.getString('review_comment') ?? '';
      _selectedTag =
          prefs.getString('review_tag') ?? (_isID ? 'Menyenangkan' : 'Fun');
      _hasLastReview = _lastRating > 0;
    });
  }

  Future<void> _submitReview() async {
    if (!_formKey.currentState!.validate()) return;

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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            _isID ? 'Terima Kasih! ❤️' : 'Thank You! ❤️',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            _isID
                ? 'Ulasanmu sangat berharga bagi pengembangan aplikasi HI KATA!'
                : 'Your review is highly valuable for the development of HI KATA!',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isID ? 'Pengalaman Belajar' : 'Learning Experience',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                // Beautiful intro banner
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text('💬', style: TextStyle(fontSize: 30)),
                      SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          _isID
                              ? 'Ulasan anda sangat membantu dalam mengembangkan fitur baru dan meningkatkan kualitas materi belajar di HI KATA.'
                              : 'Your review highly helps our team in developing new features and improving study material quality in HI KATA.',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11.5,
                            color: Colors.white,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Form Card
                Container(
                  padding: EdgeInsets.all(22),
                  decoration: AppDecorations.cardDecoration,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isID
                              ? 'Bagaimana penilaianmu?'
                              : 'How would you rate us?',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 10),

                        // Stars Rating selector
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            final ratingValue = index + 1;
                            final isFilled = ratingValue <= _rating;
                            return GestureDetector(
                              onTap: () =>
                                  setState(() => _rating = ratingValue),
                              child: Icon(
                                isFilled
                                    ? Icons.star_rounded
                                    : Icons.star_outline_rounded,
                                color: isFilled
                                    ? Colors.amber
                                    : Colors.grey.shade300,
                                size: 40,
                              ),
                            );
                          }),
                        ),
                        SizedBox(height: 18),

                        Text(
                          _isID
                              ? 'Pilih kesan pertamamu'
                              : 'Choose your first impression',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8),

                        // Impressions Wrap
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _tags.map((tag) {
                            final isSelected = tag == _selectedTag;
                            return GestureDetector(
                              onTap: () => setState(() => _selectedTag = tag),
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.softMint
                                      : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.primaryGreen
                                        : Colors.grey.shade300,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  tag,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? AppColors.textPrimary
                                        : Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 18),

                        Text(
                          _isID
                              ? 'Tulis saran & masukan'
                              : 'Write comments & suggestions',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: _commentController,
                          maxLines: 3,
                          maxLength: 150,
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
                          decoration: AppDecorations.fieldDecoration(
                            hint: _isID
                                ? 'Masukkan ulasanmu di sini...'
                                : 'Enter your feedback here...',
                            icon: Icons.edit_note_rounded,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return _isID
                                  ? 'Komentar tidak boleh kosong'
                                  : 'Feedback cannot be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12),

                        _SubmitButton(
                          label: _isID ? 'KIRIM ULASAN' : 'SUBMIT REVIEW',
                          onTap: _submitReview,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 24),

                // Last review history card
                if (_hasLastReview) ...[
                  Text(
                    _isID ? 'Ulasan Terakhirmu' : 'Your Last Review',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(18),
                    decoration: AppDecorations.cardDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < _lastRating
                                      ? Icons.star_rounded
                                      : Icons.star_border_rounded,
                                  color: Colors.amber,
                                  size: 18,
                                );
                              }),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.softMint,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                _selectedTag,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          _lastComment,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12.5,
                            color: Colors.grey.shade700,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Custom scaling submit button ──────────────────────────────────────────

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
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
    _scale = Tween<double>(
      begin: 1.0,
      end: 0.95,
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
      scale: _scale,
      child: GestureDetector(
        onTapDown: (_) => _ctrl.forward(),
        onTapUp: (_) {
          _ctrl.reverse();
          widget.onTap();
        },
        onTapCancel: () => _ctrl.reverse(),
        child: Container(
          width: double.infinity,
          height: 48,
          decoration: AppDecorations.gradientButton,
          child: Center(
            child: Text(
              widget.label,
              style: AppTextStyles.buttonText.copyWith(fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}
