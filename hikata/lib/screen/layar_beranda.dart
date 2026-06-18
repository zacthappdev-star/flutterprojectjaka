import 'package:flutter/material.dart';
import 'package:ppkd_b6/data/data_hiragana.dart';
import 'package:ppkd_b6/data/data_katakana.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/widgets/huruf/tabel_aksara_lengkap.dart';

class LayarBeranda extends StatefulWidget {
  const LayarBeranda({super.key});

  @override
  State<LayarBeranda> createState() => _LayarBerandaState();
}

class _LayarBerandaState extends State<LayarBeranda>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _fadeAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            // ── Header (Green) ──────────────────────────────────
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                bottom: 20,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF2E9E5B),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: [
                  // Decorative background elements
                  Positioned(
                    top: -40,
                    right: -40,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.05),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -20,
                    left: -20,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.04),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      FadeTransition(
                        opacity: _fadeAnim,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Translations.of(
                                  context,
                                ).common.introTablesTitle,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // ── Tab Bar ──────────────────────────────────────────
                      FadeTransition(
                        opacity: _fadeAnim,
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFC8E6C9,
                            ), // hijau muda (tidak aktif)
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TabBar(
                            controller: _tabController,
                            indicatorSize: TabBarIndicatorSize.tab,
                            splashFactory: NoSplash.splashFactory,
                            overlayColor: WidgetStateProperty.all(
                              Colors.transparent,
                            ),
                            physics: const BouncingScrollPhysics(),
                            indicator: BoxDecoration(
                              color: Colors.white, // aktif background putih
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            labelStyle: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                            unselectedLabelStyle: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            labelColor: const Color(0xFF2E9E5B),
                            unselectedLabelColor: const Color(
                              0xFF2E9E5B,
                            ).withValues(alpha: 0.6),
                            dividerColor: Colors.transparent,
                            tabs: const [
                              Tab(text: 'あ Hiragana'),
                              Tab(text: 'ア Katakana'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Progress Bar & Mulai Latihan ───────────────────────
            FadeTransition(
              opacity: _fadeAnim,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '15 karakter · 32% selesai (15/46)',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: 15 / 46,
                              backgroundColor: Colors.grey.shade200,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF2E9E5B),
                              ),
                              minHeight: 8,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E9E5B),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.play_arrow_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Mulai Latihan',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
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

            // ── Character Tables ─────────────────────────────────
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnim,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    TabelAksaraLengkap(
                      groups: HiraganaData.tableGroups,
                      isHiragana: true,
                    ),
                    TabelAksaraLengkap(
                      groups: KatakanaData.tableGroups,
                      isHiragana: false,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
