import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CryptoPortfolioPage extends StatefulWidget {
  const CryptoPortfolioPage({super.key});

  @override
  State<CryptoPortfolioPage> createState() => _CryptoPortfolioPageState();
}

class _CryptoPortfolioPageState extends State<CryptoPortfolioPage> {
  final currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  // Data tiruan
  final double btcValue = 164705990;
  final double ethValue = 51569374;
  final double bnbValue = 15812242;

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final totalPortfolio = btcValue + ethValue + bnbValue;

    return Scaffold(
      backgroundColor: Color(0xFF0D0F14),
      appBar: AppBar(
        backgroundColor: Color(0xFF0D0F14),
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
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
        ),
        title: Text(
          'Kelola Portofolio',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Saldo Kripto',
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              currencyFormat.format(totalPortfolio),
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            // Pie Chart
            SizedBox(
              height: 250,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!
                                .touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 2,
                      centerSpaceRadius: 70,
                      sections: _showingSections(totalPortfolio),
                    ),
                  ),
                  Text(
                    'Distribusi\nAset',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            // Legend
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegend(
                  'BTC',
                  Colors.orange,
                  (btcValue / totalPortfolio) * 100,
                ),
                SizedBox(width: 16),
                _buildLegend(
                  'ETH',
                  const Color(0xFF6C63FF),
                  (ethValue / totalPortfolio) * 100,
                ),
                SizedBox(width: 16),
                _buildLegend(
                  'BNB',
                  Colors.yellow,
                  (bnbValue / totalPortfolio) * 100,
                ),
              ],
            ),
            SizedBox(height: 40),
            Text(
              'Riwayat Transaksi',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _buildTransactionItem(
              'Beli Bitcoin',
              'Hari ini, 10:42',
              '+0.015 BTC',
              true,
            ),
            _buildTransactionItem(
              'Kirim Ethereum',
              'Kemarin, 15:20',
              '-0.5 ETH',
              false,
            ),
            _buildTransactionItem('Beli BNB', '12 Jun 2026', '+1.6 BNB', true),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _showingSections(double total) {
    return [
      _buildSection(0, btcValue, total, Colors.orange, 'BTC'),
      _buildSection(1, ethValue, total, Color(0xFF6C63FF), 'ETH'),
      _buildSection(2, bnbValue, total, Colors.yellow, 'BNB'),
    ];
  }

  PieChartSectionData _buildSection(
    int index,
    double value,
    double total,
    Color color,
    String title,
  ) {
    final isTouched = index == touchedIndex;
    final fontSize = isTouched ? 16.0 : 12.0;
    final radius = isTouched ? 60.0 : 50.0;
    final percentage = (value / total * 100).toStringAsFixed(1);

    return PieChartSectionData(
      color: color,
      value: value,
      title: '$percentage%',
      radius: radius,
      titleStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        shadows: [Shadow(color: Colors.black, blurRadius: 2)],
      ),
    );
  }

  Widget _buildLegend(String label, Color color, double percentage) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 6),
        Text(
          '$label (${percentage.toStringAsFixed(0)}%)',
          style: TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildTransactionItem(
    String title,
    String date,
    String amount,
    bool isIncome,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF1A1D28),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF2A2D36)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isIncome
                  ? Color(0xFF38D782).withValues(alpha: 0.1)
                  : Color(0xFFFF5C5C).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isIncome
                  ? Icons.arrow_downward_rounded
                  : Icons.arrow_upward_rounded,
              color: isIncome ? Color(0xFF38D782) : Color(0xFFFF5C5C),
              size: 20,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: isIncome ? Color(0xFF38D782) : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
