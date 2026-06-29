import 'package:flutter/material.dart';
import 'package:ppkd_b6/local/database/preference_handler.dart';
import 'package:ppkd_b6/loginn.dart';

class CryptoSettingsPage extends StatefulWidget {
  const CryptoSettingsPage({super.key});

  @override
  State<CryptoSettingsPage> createState() => _CryptoSettingsPageState();
}

class _CryptoSettingsPageState extends State<CryptoSettingsPage> {
  String _displayName = 'Memuat...';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  void _loadProfileData() {
    _email = Preference.getUserEmail();
    String savedName = Preference.getUserName();

    setState(() {
      if (savedName.isNotEmpty) {
        _displayName = savedName;
      } else if (_email.isNotEmpty) {
        _displayName = _email.split('@').first;
      } else {
        _displayName = 'User Crypto';
      }
    });
  }

  void _showEditNameDialog() {
    final TextEditingController nameController = TextEditingController(
      text: _displayName,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xFF1A1D28),
          title: Text('Ubah Nama', style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: nameController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Nama panggilan baru',
              hintStyle: TextStyle(color: Colors.white38),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2A2D36)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF38D782)),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Batal', style: TextStyle(color: Colors.white54)),
            ),
            ElevatedButton(
              onPressed: () async {
                final newName = nameController.text.trim();
                if (newName.isNotEmpty) {
                  await Preference.setUserName(newName);
                  _loadProfileData();
                }
                if (context.mounted) Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF38D782),
              ),
              child: const Text(
                'Simpan',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _logout() async {
    await Preference.clearAll();
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      TampilanLogin.routeName,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F14),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F14),
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
          'Pengaturan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Color(0xFF1A1D28),
                  child: Icon(Icons.person, color: Colors.white54, size: 50),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _showEditNameDialog,
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Color(0xFF38D782),
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(0xFF0D0F14), width: 2),
                      ),
                      child: Icon(Icons.edit, color: Colors.white, size: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text(
            _displayName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            _email.isEmpty ? 'Tidak ada email' : _email,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white54, fontSize: 13),
          ),
          SizedBox(height: 32),
          _buildListTile(Icons.edit, 'Ubah Nama', onTap: _showEditNameDialog),
          _buildListTile(Icons.security, 'Keamanan & Privasi'),
          _buildListTile(Icons.notifications, 'Notifikasi'),
          _buildListTile(Icons.language, 'Bahasa'),
          SizedBox(height: 20),
          _buildListTile(
            Icons.logout,
            'Keluar',
            isDestructive: true,
            onTap: _logout,
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(
    IconData icon,
    String title, {
    bool isDestructive = false,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Color(0xFF1A1D28),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF2A2D36)),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isDestructive ? Color(0xFFFF5C5C) : Color(0xFF38D782),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isDestructive ? Color(0xFFFF5C5C) : Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.white38),
        onTap: onTap ?? () {},
      ),
    );
  }
}
