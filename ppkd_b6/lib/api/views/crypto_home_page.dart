import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppkd_b6/api/models/crypto_models.dart';
import 'package:ppkd_b6/api/providers/crypto_provider.dart';
import 'package:ppkd_b6/api/views/crypto_action_page.dart';
import 'package:ppkd_b6/api/views/crypto_portfolio_page.dart';
import 'package:ppkd_b6/api/views/crypto_settings_page.dart';
import 'package:ppkd_b6/api/views/cypto_detail.dart';
import 'package:ppkd_b6/local/database/preference_handler.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

// Color System
const Color kBg = Color(0xFF0D0F14);
const Color kCard = Color(0xFF1A1D28);
const Color kAccentGreen = Color(0xFF38D782);
const Color kNegative = Color(0xFFFF5C5C);
const Color kTextPrimary = Color(0xFFFFFFFF);
const Color kTextMuted = Color(0xFF7A7D8E);
const Color kBorder = Color(0xFF2A2D36);
const Color kIconBg = Color(0xFF1E2230);

class CryptoHomePage extends StatefulWidget {
  final VoidCallback? onNavigateToMarket;
  const CryptoHomePage({super.key, this.onNavigateToMarket});

  @override
  State<CryptoHomePage> createState() => _CryptoHomePageState();
}

class _CryptoHomePageState extends State<CryptoHomePage> {
  // Dummy balances for "Aset Saya"
  final double dummyBtc = 0.1542;
  final double dummyEth = 1.83;
  final double dummyBnb = 1.60;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _refreshData() async {
    await context.read<CryptoProvider>().fetchCryptos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Consumer<CryptoProvider>(
          builder: (context, provider, child) {
            if (provider.state == ProviderState.initial ||
                provider.state == ProviderState.loading) {
              return _buildShimmerLoading();
            }

            if (provider.state == ProviderState.error) {
              return _buildError(provider.errorMessage);
            }

            final cryptos = provider.cryptos;
            if (cryptos.isEmpty) {
              return _buildError('Data tidak ditemukan');
            }

            // Calculate Portfolio Value
            final btc = cryptos.firstWhere(
              (c) => c.symbol.toLowerCase() == 'btc',
              orElse: () => cryptos.first,
            );
            final eth = cryptos.firstWhere(
              (c) => c.symbol.toLowerCase() == 'eth',
              orElse: () => cryptos.first,
            );
            final bnb = cryptos.firstWhere(
              (c) => c.symbol.toLowerCase() == 'bnb',
              orElse: () => cryptos.first,
            );

            final btcValue = dummyBtc * btc.currentPrice;
            final ethValue = dummyEth * eth.currentPrice;
            final bnbValue = dummyBnb * bnb.currentPrice;
            final totalPortfolio = btcValue + ethValue + bnbValue;

            final avgChange = btc.priceChangePercentage24H ?? 0.0;
            final changeValue = totalPortfolio * (avgChange / 100);

            final trending = cryptos.take(3).toList();

            return RefreshIndicator(
              onRefresh: _refreshData,
              color: kAccentGreen,
              backgroundColor: kCard,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatusBar(),
                    _buildHeader(),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: _buildPortfolioCard(
                        totalPortfolio,
                        changeValue,
                        avgChange,
                      ),
                    ),
                    SizedBox(height: 32),
                    _buildTrendingSection(trending),
                    SizedBox(height: 32),
                    _buildAssetsSection(
                      btc,
                      eth,
                      bnb,
                      btcValue,
                      ethValue,
                      bnbValue,
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusBar(),
          _buildHeader(),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Shimmer.fromColors(
              baseColor: kCard,
              highlightColor: kBorder,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
          SizedBox(height: 32),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Shimmer.fromColors(
              baseColor: kCard,
              highlightColor: kBorder,
              child: Container(height: 24, width: 150, color: Colors.white),
            ),
          ),
          SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                3,
                (index) => Container(
                  width: 140,
                  height: 140,
                  margin: EdgeInsets.symmetric(horizontal: 6),
                  child: Shimmer.fromColors(
                    baseColor: kCard,
                    highlightColor: kBorder,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(String msg) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.wifi_off_rounded, color: Colors.white24, size: 40),
          SizedBox(height: 12),
          Text(
            'Gagal memuat data',
            style: TextStyle(color: Colors.white54, fontSize: 14),
          ),
          SizedBox(height: 4),
          Text(msg, style: TextStyle(color: Colors.white24, fontSize: 11)),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _refreshData,
            style: ElevatedButton.styleFrom(backgroundColor: kAccentGreen),
            child: Text('Coba Lagi', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '9:41',
            style: TextStyle(
              color: kTextPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Icon(Icons.signal_cellular_4_bar, color: kTextPrimary, size: 16),
              SizedBox(width: 6),
              Icon(Icons.wifi, color: kTextPrimary, size: 16),
              SizedBox(width: 6),
              Icon(Icons.battery_full, color: kTextPrimary, size: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    String display = Preference.getUserName();
    if (display.isEmpty) {
      final email = Preference.getUserEmail();
      display = email.isNotEmpty ? email.split('@').first : 'User Crypto';
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat datang 👋',
                style: TextStyle(color: kTextMuted, fontSize: 13),
              ),
              SizedBox(height: 4),
              Text(
                display,
                style: TextStyle(
                  color: kTextPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildCircleButton(Icons.notifications_none, 'Notifikasi'),
              SizedBox(width: 12),
              _buildCircleButton(Icons.settings_outlined, 'Pengaturan'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton(IconData icon, String type) {
    return InkWell(
      onTap: () async {
        if (type == 'Pengaturan') {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CryptoSettingsPage()),
          );
          // Rebuild to refresh name
          setState(() {});
        } else {
          _showSnackBar('Fitur $type belum tersedia');
        }
      },
      borderRadius: BorderRadius.circular(22),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(color: kIconBg, shape: BoxShape.circle),
        child: Icon(icon, color: kTextPrimary, size: 20),
      ),
    );
  }

  Widget _buildPortfolioCard(double total, double changeVal, double avgPct) {
    final isUp = avgPct >= 0;
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A3A2A), Color(0xFF0F2D1E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TOTAL PORTFOLIO',
            style: TextStyle(
              color: kAccentGreen.withValues(alpha: 0.8),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 8),
          Text(
            _formatRupiah(total),
            style: TextStyle(
              color: kTextPrimary,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(
                isUp ? Icons.arrow_upward : Icons.arrow_downward,
                color: kAccentGreen,
                size: 14,
              ),
              SizedBox(width: 4),
              Text(
                '${isUp ? '+' : '-'}${_formatRupiah(changeVal.abs())} (${avgPct.toStringAsFixed(2)}%) hari ini',
                style: TextStyle(
                  color: kAccentGreen,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPortfolioAction(Icons.add_shopping_cart, 'Beli'),
              _buildPortfolioAction(Icons.arrow_upward, 'Kirim'),
              _buildPortfolioAction(Icons.arrow_downward, 'Terima'),
              _buildPortfolioAction(Icons.grid_view_rounded, 'Lainnya'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioAction(IconData icon, String label) {
    return InkWell(
      onTap: () {
        if (label == 'Beli' || label == 'Kirim' || label == 'Terima') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CryptoActionPage(actionType: label),
            ),
          );
        } else {
          _showSnackBar('Fitur $label belum tersedia');
        }
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: kAccentGreen, size: 22),
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: kTextPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingSection(List<CryptoModels> trending) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending sekarang',
                style: TextStyle(
                  color: kTextPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  if (widget.onNavigateToMarket != null) {
                    widget.onNavigateToMarket!();
                  } else {
                    _showSnackBar('Melihat semua trending');
                  }
                },
                child: Text(
                  'Lihat semua',
                  style: TextStyle(
                    color: kAccentGreen,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: trending.map((c) => _buildTrendingCard(c)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingCard(CryptoModels coin) {
    final isUp = (coin.priceChangePercentage24H ?? 0) >= 0;

    // Assign some dynamic colors for icons just for aesthetics since we use networks images
    final colors = [
      Colors.orange,
      Colors.blue,
      Colors.purple,
      Colors.green,
      Colors.teal,
    ];
    final color = colors[coin.marketCapRank % colors.length];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CryptoDetailPage(crypto: coin)),
        );
      },
      child: Container(
        width: 150,
        margin: EdgeInsets.symmetric(horizontal: 6),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: kBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.network(
                      coin.image,
                      width: 20,
                      height: 20,
                      errorBuilder: (_, _, _) =>
                          Icon(Icons.currency_bitcoin, color: color, size: 20),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    coin.symbol.toUpperCase(),
                    style: TextStyle(
                      color: kTextPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              _formatRupiah(coin.currentPrice),
              style: TextStyle(
                color: kTextPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '${isUp ? '+' : ''}${coin.priceChangePercentage24H?.toStringAsFixed(2)}%',
              style: TextStyle(
                color: isUp ? kAccentGreen : kNegative,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetsSection(
    CryptoModels btc,
    CryptoModels eth,
    CryptoModels bnb,
    double btcVal,
    double ethVal,
    double bnbVal,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Aset saya',
                style: TextStyle(
                  color: kTextPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CryptoPortfolioPage()),
                  );
                },
                child: Text(
                  'Kelola',
                  style: TextStyle(
                    color: kAccentGreen,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: kCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: kBorder),
            ),
            child: Column(
              children: [
                _buildAssetItem(btc, dummyBtc, btcVal, Colors.orange),
                Divider(color: kBorder, height: 1, indent: 64),
                _buildAssetItem(eth, dummyEth, ethVal, Colors.blue),
                Divider(color: kBorder, height: 1, indent: 64),
                _buildAssetItem(bnb, dummyBnb, bnbVal, Colors.yellow[600]!),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssetItem(
    CryptoModels coin,
    double amount,
    double value,
    Color iconColor,
  ) {
    final isUp = (coin.priceChangePercentage24H ?? 0) >= 0;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CryptoDetailPage(crypto: coin)),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(8),
              child: ClipOval(
                child: Image.network(
                  coin.image,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) =>
                      Icon(Icons.currency_bitcoin, color: iconColor, size: 22),
                ),
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coin.name,
                    style: TextStyle(
                      color: kTextPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${amount.toString()} ${coin.symbol.toUpperCase()}',
                    style: TextStyle(color: kTextMuted, fontSize: 13),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formatRupiah(value),
                  style: const TextStyle(
                    color: kTextPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '${isUp ? '+' : ''}${coin.priceChangePercentage24H?.toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: isUp ? kAccentGreen : kNegative,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: kCard,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  String _formatRupiah(double amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(amount);
  }
}
