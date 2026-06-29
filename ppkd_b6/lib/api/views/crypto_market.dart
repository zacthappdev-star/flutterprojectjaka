import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppkd_b6/api/models/crypto_models.dart';
import 'package:ppkd_b6/api/providers/crypto_provider.dart';
import 'package:ppkd_b6/api/views/crypto_settings_page.dart';
import 'package:ppkd_b6/api/views/cypto_detail.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

// =============================================
// TEMA WARNA — ubah di sini kalau mau ganti palet
// =============================================
const Color kBg = Color(0xFF0B0F1A);
const Color kSurface = Color(0xFF131829);
const Color kCard = Color(0xFF161C2E);
const Color kAccent = Color(0xFF6C63FF);
const Color kGreen = Color(0xFF22C55E);
const Color kRed = Color(0xFFF43F5E);
const Color kBorder = Color(0x14FFFFFF);

class CryptoMarketPage extends StatefulWidget {
  const CryptoMarketPage({super.key});

  @override
  State<CryptoMarketPage> createState() => _CryptoMarketPageState();
}

class _CryptoMarketPageState extends State<CryptoMarketPage> {
  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  // Tab filter aktif: 'Semua' | 'Top 10' | 'Naik' | 'Turun'
  String _activeTab = 'Semua';
  final List<String> _tabs = ['Semua', 'Top 10', 'Naik', 'Turun'];

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  Future<void> _refreshData() async {
    await context.read<CryptoProvider>().fetchCryptos();
  }

  // Filter gabungan: search + tab
  List<CryptoModels> _applyFilter(List<CryptoModels> list) {
    final query = searchController.text.toLowerCase();
    var result = query.isEmpty
        ? list
        : list.where((c) => c.name.toLowerCase().contains(query)).toList();

    switch (_activeTab) {
      case 'Top 10':
        result = result.take(10).toList();
        break;
      case 'Naik':
        result = result
            .where((c) => (c.priceChangePercentage24H ?? 0) >= 0)
            .toList();
        break;
      case 'Turun':
        result = result
            .where((c) => (c.priceChangePercentage24H ?? 0) < 0)
            .toList();
        break;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildTabs(),
            _buildColumnLabels(),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  // ── Header ──────────────────────────────────
  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Crypto Market',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              _iconBtn(Icons.notifications_outlined),
              SizedBox(width: 8),
              _iconBtn(
                Icons.settings_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CryptoSettingsPage()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconBtn(IconData icon, {VoidCallback? onTap}) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: Colors.white54, size: 17),
    ),
  );

  // ── Search Bar ──────────────────────────────
  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          border: Border.all(color: kBorder),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: Colors.white.withValues(alpha: 0.25),
              size: 17,
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: searchController,
                style: TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Cari crypto...',
                  hintStyle: TextStyle(
                    color: Colors.white.withValues(alpha: 0.2),
                    fontSize: 14,
                  ),
                  isDense: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            if (searchController.text.isNotEmpty)
              GestureDetector(
                onTap: () => searchController.clear(),
                child: Icon(Icons.close, color: Colors.white38, size: 16),
              ),
          ],
        ),
      ),
    );
  }

  // ── Filter Tabs ─────────────────────────────
  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _tabs.map((tab) {
            final active = tab == _activeTab;
            return Padding(
              padding: EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => setState(() => _activeTab = tab),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                  decoration: BoxDecoration(
                    color: active
                        ? kAccent
                        : Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: active ? null : Border.all(color: kBorder),
                  ),
                  child: Text(
                    tab,
                    style: TextStyle(
                      color: active ? Colors.white : Colors.white54,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ── Column Labels ───────────────────────────
  Widget _buildColumnLabels() {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 12, 24, 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('NAMA', style: _labelStyle),
          Text('HARGA / 24J', style: _labelStyle),
        ],
      ),
    );
  }

  TextStyle get _labelStyle => TextStyle(
    fontSize: 10,
    color: Colors.white.withValues(alpha: 0.25),
    letterSpacing: 0.7,
    fontWeight: FontWeight.w500,
  );

  // ── Body: Consumer ─────────────────────
  Widget _buildBody() {
    return Consumer<CryptoProvider>(
      builder: (context, provider, child) {
        if (provider.state == ProviderState.initial ||
            provider.state == ProviderState.loading) {
          return _buildShimmerList();
        }
        if (provider.state == ProviderState.error) {
          return _buildError(provider.errorMessage);
        }
        if (provider.cryptos.isEmpty) {
          return _buildEmpty('Data tidak ditemukan');
        }

        final filtered = _applyFilter(provider.cryptos);
        if (filtered.isEmpty) {
          return _buildEmpty('Pencarian tidak ditemukan');
        }

        return RefreshIndicator(
          onRefresh: _refreshData,
          color: kAccent,
          backgroundColor: kSurface,
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            itemCount: filtered.length,
            itemBuilder: (context, index) => _CoinTile(coin: filtered[index]),
          ),
        );
      },
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 4),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.white.withValues(alpha: 0.05),
                highlightColor: Colors.white.withValues(alpha: 0.1),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.white.withValues(alpha: 0.05),
                      highlightColor: Colors.white.withValues(alpha: 0.1),
                      child: Container(
                        width: 100,
                        height: 14,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Shimmer.fromColors(
                      baseColor: Colors.white.withValues(alpha: 0.05),
                      highlightColor: Colors.white.withValues(alpha: 0.1),
                      child: Container(
                        width: 40,
                        height: 10,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Shimmer.fromColors(
                baseColor: Colors.white.withValues(alpha: 0.05),
                highlightColor: Colors.white.withValues(alpha: 0.1),
                child: Container(width: 60, height: 14, color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildError(String msg) => Center(
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
        GestureDetector(
          onTap: _refreshData,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: kAccent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Coba Lagi',
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildEmpty(String msg) => Center(
    child: Text(msg, style: TextStyle(color: Colors.white38, fontSize: 14)),
  );
}

// =============================================
// COIN TILE WIDGET
// =============================================
class _CoinTile extends StatelessWidget {
  final CryptoModels coin;
  const _CoinTile({required this.coin});

  @override
  Widget build(BuildContext context) {
    final isUp = (coin.priceChangePercentage24H ?? 0) >= 0;
    final changeColor = isUp ? kGreen : kRed;
    final changeBg = isUp
        ? kGreen.withValues(alpha: 0.12)
        : kRed.withValues(alpha: 0.12);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => CryptoDetailPage(crypto: coin)),
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 4),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // ── Avatar + Rank Badge ──
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    coin.image,
                    width: 40,
                    height: 40,
                    errorBuilder: (_, _, _) => Container(
                      width: 40,
                      height: 40,
                      color: Colors.white10,
                      child: Icon(
                        Icons.currency_bitcoin,
                        color: Colors.white24,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -3,
                  right: -3,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: kSurface,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${coin.marketCapRank}',
                      style: TextStyle(
                        fontSize: 7,
                        color: Colors.white.withValues(alpha: 0.5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(width: 12),

            // ── Name & Symbol ──
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coin.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2),
                  Text(
                    coin.symbol.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.3),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),

            // ── Price & Change ──
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formatRupiah(coin.currentPrice),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: changeBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isUp ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        color: changeColor,
                        size: 14,
                      ),
                      Text(
                        '${coin.priceChangePercentage24H?.toStringAsFixed(2)}%',
                        style: TextStyle(
                          color: changeColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Format harga: angka besar pakai koma, kecil pakai desimal
  String _formatRupiah(double amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(amount);
  }
}
