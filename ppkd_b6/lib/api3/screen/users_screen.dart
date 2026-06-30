import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/api_services.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final ApiService _apiService = ApiService();
  List<UserModel> _users = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final response = await _apiService.getAllUsers();
      final List data = response.data['data'] ?? [];
      if (mounted) {
        setState(() {
          _users = data.map((json) => UserModel.fromJson(json)).toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $_error', style: TextStyle(color: Colors.red)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchUsers,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }
    if (_users.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 80, color: Colors.grey.shade300),
            SizedBox(height: 16),
            Text(
              'Belum ada pengguna.',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      itemCount: _users.length,
      itemBuilder: (context, index) {
        final user = _users[index];
        return Card(
          elevation: 4,
          shadowColor: Colors.black12,
          margin: EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue.shade200, width: 2),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade100,
                  backgroundImage:
                      user.profilePhoto != null && user.profilePhoto!.isNotEmpty
                      ? (user.profilePhoto!.startsWith('data:image')
                            ? MemoryImage(
                                    base64Decode(
                                      user.profilePhoto!.split(',').last,
                                    ),
                                  )
                                  as ImageProvider
                            : NetworkImage(
                                user.profilePhoto!.startsWith('http')
                                    ? user.profilePhoto!
                                    : 'https://appabsensi.mobileprojp.com/${user.profilePhoto!.startsWith('/') ? user.profilePhoto!.substring(1) : user.profilePhoto!}',
                              ))
                      : null,
                  child: user.profilePhoto == null || user.profilePhoto!.isEmpty
                      ? Icon(Icons.person, color: Colors.grey.shade400)
                      : null,
                ),
              ),
              title: Text(
                user.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              subtitle: Text(
                user.email,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey.shade300,
              ),
            ),
          ),
        );
      },
    );
  }
}
