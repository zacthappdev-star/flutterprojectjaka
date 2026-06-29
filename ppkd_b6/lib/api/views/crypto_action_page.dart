import 'package:flutter/material.dart';

class CryptoActionPage extends StatefulWidget {
  final String actionType;

  const CryptoActionPage({super.key, required this.actionType});

  @override
  State<CryptoActionPage> createState() => _CryptoActionPageState();
}

class _CryptoActionPageState extends State<CryptoActionPage> {
  final _amountController = TextEditingController();
  final _addressController = TextEditingController();
  String _selectedCoin = 'BTC';

  @override
  void dispose() {
    _amountController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          widget.actionType,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (widget.actionType) {
      case 'Beli':
        return _buildBuyUI();
      case 'Kirim':
        return _buildSendUI();
      case 'Terima':
        return _buildReceiveUI();
      default:
        return Center(
          child: Text(
            'Aksi tidak dikenali',
            style: TextStyle(color: Colors.white),
          ),
        );
    }
  }

  // ── UI Beli ──
  Widget _buildBuyUI() {
    return Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Beli Kripto',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Masukkan jumlah dalam Rupiah',
            style: TextStyle(color: Colors.white54, fontSize: 14),
          ),
          SizedBox(height: 40),
          // Coin Selector
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCoinChip('BTC'),
              SizedBox(width: 12),
              _buildCoinChip('ETH'),
              SizedBox(width: 12),
              _buildCoinChip('BNB'),
            ],
          ),
          SizedBox(height: 40),
          // Amount Input
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              hintText: 'Rp 0',
              hintStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.2),
                fontSize: 42,
              ),
              border: InputBorder.none,
            ),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Pembelian $_selectedCoin senilai ${_amountController.text} berhasil disimulasikan!',
                  ),
                ),
              );
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF38D782),
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Konfirmasi Pembelian',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCoinChip(String symbol) {
    final isSelected = _selectedCoin == symbol;
    return GestureDetector(
      onTap: () => setState(() => _selectedCoin = symbol),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF38D782) : Color(0xFF1A1D28),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Color(0xFF38D782) : Color(0xFF2A2D36),
          ),
        ),
        child: Text(
          symbol,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // ── UI Kirim ──
  Widget _buildSendUI() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Kirim Kripto',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 32),
          Text(
            'Aset yang dikirim',
            style: TextStyle(color: Colors.white54, fontSize: 13),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Color(0xFF1A1D28),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF2A2D36)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.currency_bitcoin,
                      color: Colors.orange,
                      size: 24,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Bitcoin (BTC)',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.keyboard_arrow_down, color: Colors.white54),
              ],
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Alamat Tujuan',
            style: TextStyle(color: Colors.white54, fontSize: 13),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _addressController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Masukkan alamat wallet...',
              hintStyle: TextStyle(color: Colors.white38),
              filled: true,
              fillColor: Color(0xFF1A1D28),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              suffixIcon: Icon(Icons.qr_code_scanner, color: Color(0xFF38D782)),
            ),
          ),
          SizedBox(height: 24),
          Text('Jumlah', style: TextStyle(color: Colors.white54, fontSize: 13)),
          SizedBox(height: 8),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: '0.00 BTC',
              hintStyle: TextStyle(color: Colors.white38),
              filled: true,
              fillColor: Color(0xFF1A1D28),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              suffixIcon: TextButton(
                onPressed: () {},
                child: Text('MAX', style: TextStyle(color: Color(0xFF38D782))),
              ),
            ),
          ),
          SizedBox(height: 40),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF38D782).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Network Fee', style: TextStyle(color: Colors.white70)),
                Text(
                  '~0.00012 BTC',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Simulasi pengiriman berhasil!')),
              );
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF38D782),
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Kirim Sekarang',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── UI Terima ──
  Widget _buildReceiveUI() {
    final String walletAddress = 'bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh';

    return Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text(
            'Pindai QR Code',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Hanya kirim Bitcoin (BTC) ke alamat ini.\nMengirim aset lain dapat menyebabkan kehilangan dana.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
          SizedBox(height: 40),
          // Fake QR Code box
          Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.qr_code_2,
                  size: 200,
                  color: Colors.black.withValues(alpha: 0.8),
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.currency_bitcoin,
                    color: Colors.orange,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          Text(
            'Alamat Dompet Anda',
            style: TextStyle(color: Colors.white54, fontSize: 13),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Color(0xFF1A1D28),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFF2A2D36)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    walletAddress,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Alamat disalin ke clipboard')),
                    );
                  },
                  child: Icon(Icons.copy, color: Color(0xFF38D782), size: 20),
                ),
              ],
            ),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF1A1D28),
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Color(0xFF2A2D36)),
              ),
              minimumSize: Size(double.infinity, 50),
            ),
            child: Text(
              'Bagikan Alamat',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
