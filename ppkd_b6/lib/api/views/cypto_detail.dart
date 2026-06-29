import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppkd_b6/api/models/crypto_models.dart';
import 'package:ppkd_b6/api/services/api_services.dart';

// Konstanta warna
const Color kBg = Color(0xFF0B0F1A);
const Color kSurface = Color(0xFF131829);
const Color kAccent = Color(0xFF6C63FF);
const Color kGreen = Color(0xFF22C55E);
const Color kRed = Color(0xFFF43F5E);
const Color kBorder = Color(0x14FFFFFF);
const Color kCard = Color(0xFF161C2E);

class CryptoDetailPage extends StatefulWidget {
  final CryptoModels crypto;
  const CryptoDetailPage({super.key, required this.crypto});

  @override
  State<CryptoDetailPage> createState() => _CryptoDetailPageState();
}

class _CryptoDetailPageState extends State<CryptoDetailPage> {
  final ApiService _apiService = ApiService(Dio());
  List<FlSpot> _chartData = [];
  bool _isChartLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchChartData();
  }

  Future<void> _fetchChartData() async {
    try {
      final data = await _apiService.getCryptoChart(widget.crypto.id, 'idr', 7);
      if (data['prices'] != null) {
        final prices = data['prices'] as List<dynamic>;

        if (prices.isNotEmpty) {
          final List<FlSpot> spots = [];

          double minTime = prices.first[0].toDouble();

          for (int i = 0; i < prices.length; i++) {
            final double time = prices[i][0].toDouble();
            final double price = prices[i][1].toDouble();

            // Normalize time starting from 0 for X axis
            final double x =
                (time - minTime) / 86400000; // converted to days offset roughly
            spots.add(FlSpot(x, price));
          }

          setState(() {
            _chartData = spots;
            _isChartLoading = false;
          });
        }
      }
    } catch (e) {
      debugPrint('Error fetching chart: $e');
      setState(() {
        _isChartLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUp = (widget.crypto.priceChangePercentage24H ?? 0) >= 0;
    final changeColor = isUp ? kGreen : kRed;

    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: Column(
                  children: [
                    _buildHero(isUp, changeColor),
                    SizedBox(height: 24),
                    _buildChartSection(changeColor),
                    SizedBox(height: 24),
                    _buildPriceRange(),
                    SizedBox(height: 14),
                    _buildStatsGrid(),
                    SizedBox(height: 14),
                    _buildInfoCards(),
                    SizedBox(height: 20),
                    _buildLastUpdated(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Custom AppBar ────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 14, 20, 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white54,
                size: 15,
              ),
            ),
          ),
          SizedBox(width: 12),
          Text(
            widget.crypto.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '#${widget.crypto.marketCapRank}',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Hero: logo + harga ───────────────────────
  Widget _buildHero(bool isUp, Color changeColor) {
    return Column(
      children: [
        // Logo
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              widget.crypto.image,
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) =>
                  Icon(Icons.currency_bitcoin, color: Colors.white24, size: 32),
            ),
          ),
        ),
        SizedBox(height: 14),
        Text(
          widget.crypto.symbol.toUpperCase(),
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.35),
            fontSize: 13,
            letterSpacing: 1.2,
          ),
        ),

        SizedBox(height: 8),

        // Harga besar
        Text(
          _formatRupiah(widget.crypto.currentPrice),
          style: TextStyle(
            color: Colors.white,
            fontSize: 34,
            fontWeight: FontWeight.w700,
          ),
        ),

        SizedBox(height: 8),

        // Badge perubahan
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: changeColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isUp ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: changeColor,
                size: 18,
              ),
              Text(
                '${(widget.crypto.priceChangePercentage24H ?? 0.0).toStringAsFixed(2)}%  (24j)',
                style: TextStyle(
                  color: changeColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Line Chart Section ───────────────────────
  Widget _buildChartSection(Color lineColor) {
    if (_isChartLoading) {
      return Container(
        height: 220,
        alignment: Alignment.center,
        child: CircularProgressIndicator(color: kAccent, strokeWidth: 2),
      );
    }

    if (_chartData.isEmpty) {
      return Container(
        height: 220,
        alignment: Alignment.center,
        child: Text(
          'Gagal memuat grafik',
          style: TextStyle(color: Colors.white38),
        ),
      );
    }

    double minY = _chartData.map((e) => e.y).reduce((a, b) => a < b ? a : b);
    double maxY = _chartData.map((e) => e.y).reduce((a, b) => a > b ? a : b);

    // Padding for visual room
    double paddingY = (maxY - minY) * 0.1;

    return SizedBox(
      height: 220,
      width: double.infinity,
      child: LineChart(
        LineChartData(
          minY: minY - paddingY,
          maxY: maxY + paddingY,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: paddingY > 0 ? paddingY * 2 : null,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.white.withValues(alpha: 0.05),
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => kCard,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  return LineTooltipItem(
                    _formatRupiah(spot.y),
                    TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  );
                }).toList();
              },
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: _chartData,
              isCurved: true,
              color: lineColor,
              barWidth: 2.5,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    lineColor.withValues(alpha: 0.3),
                    lineColor.withValues(alpha: 0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── High / Low 24J ──────────────────────────
  Widget _buildPriceRange() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        border: Border.all(color: kBorder),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rendah 24J',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.4),
                  fontSize: 12,
                ),
              ),
              Text(
                'Tinggi 24J',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.4),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatRupiah(widget.crypto.low24H ?? 0),
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                _formatRupiah(widget.crypto.high24H ?? 0),
                style: TextStyle(
                  color: kGreen,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          // Progress bar range harga
          _buildRangeBar(),
        ],
      ),
    );
  }

  Widget _buildRangeBar() {
    final low = widget.crypto.low24H ?? 0;
    final high = widget.crypto.high24H ?? 0;
    final cur = widget.crypto.currentPrice;
    final range = high - low;
    final ratio = range > 0 ? ((cur - low) / range).clamp(0.0, 1.0) : 0.5;

    return LayoutBuilder(
      builder: (_, constraints) {
        return Stack(
          children: [
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Container(
              height: 4,
              width: constraints.maxWidth * ratio,
              decoration: BoxDecoration(
                color: kAccent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        );
      },
    );
  }

  // ── Stats 2x2 Grid ──────────────────────────
  Widget _buildStatsGrid() {
    final stats = [
      _StatItem(
        icon: Icons.account_balance_wallet_outlined,
        label: 'Market Cap',
        value: _formatLargeNum(widget.crypto.marketCap),
      ),
      _StatItem(
        icon: Icons.bar_chart_rounded,
        label: 'Volume 24J',
        value: _formatLargeNum((widget.crypto.totalVolume ?? 0).toDouble()),
      ),
      _StatItem(
        icon: Icons.pie_chart_outline,
        label: 'Supply Beredar',
        value: _formatLargeNum(widget.crypto.circulatingSupply),
      ),
      _StatItem(
        icon: Icons.inventory_2_outlined,
        label: 'Total Supply',
        value: _formatLargeNum(widget.crypto.totalSupply),
      ),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2.2,
      children: stats.map((s) => _buildStatCard(s)).toList(),
    );
  }

  Widget _buildStatCard(_StatItem s) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        border: Border.all(color: kBorder),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(s.icon, color: Colors.white24, size: 14),
              SizedBox(width: 5),
              Text(
                s.label,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.35),
                  fontSize: 11,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            s.value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ── ATH / ATL Cards ─────────────────────────
  Widget _buildInfoCards() {
    return Column(
      children: [
        _infoRow(
          icon: Icons.emoji_events_outlined,
          iconColor: Color(0xFFFBBF24),
          label: 'All Time High',
          value: _formatRupiah(widget.crypto.ath),
          sub:
              '${widget.crypto.athChangePercentage.toStringAsFixed(1)}% dari ATH',
          subColor: kRed,
        ),
        SizedBox(height: 10),
        _infoRow(
          icon: Icons.trending_down_rounded,
          iconColor: kRed,
          label: 'All Time Low',
          value: _formatRupiah(widget.crypto.atl),
          sub:
              '+${widget.crypto.atlChangePercentage.toStringAsFixed(0)}% dari ATL',
          subColor: kGreen,
        ),
      ],
    );
  }

  Widget _infoRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required String sub,
    required Color subColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        border: Border.all(color: kBorder),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.35),
                    fontSize: 11,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Text(
            sub,
            style: TextStyle(
              color: subColor,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ── Last Updated ─────────────────────────────
  Widget _buildLastUpdated() {
    final t = widget.crypto.lastUpdated;
    final formatted =
        '${t.day.toString().padLeft(2, '0')}/${t.month.toString().padLeft(2, '0')}/${t.year}  '
        '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.update_rounded, color: Colors.white24, size: 13),
        SizedBox(width: 5),
        Text(
          'Diperbarui $formatted',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.2),
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  // ── Helpers ──────────────────────────────────
  String _formatRupiah(double amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(amount);
  }

  String _formatLargeNum(double n) {
    if (n >= 1e12) return 'Rp ${(n / 1e12).toStringAsFixed(2)} T';
    if (n >= 1e9) return 'Rp ${(n / 1e9).toStringAsFixed(2)} Miliar';
    if (n >= 1e6) return 'Rp ${(n / 1e6).toStringAsFixed(2)} Juta';
    return _formatRupiah(n);
  }
}

// Data class kecil untuk stat card
class _StatItem {
  final IconData icon;
  final String label;
  final String value;
  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
  });
}
