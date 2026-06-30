import 'package:flutter/material.dart';

import '../models/batch_model.dart';
import '../services/api_services.dart';

class BatchesScreen extends StatefulWidget {
  const BatchesScreen({super.key});

  @override
  State<BatchesScreen> createState() => _BatchesScreenState();
}

class _BatchesScreenState extends State<BatchesScreen> {
  final ApiService _apiService = ApiService();
  List<BatchModel> _batches = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchBatches();
  }

  Future<void> _fetchBatches() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final response = await _apiService.getBatches();
      final List data = response.data['data'] ?? [];
      if (mounted) {
        setState(() {
          _batches = data.map((json) => BatchModel.fromJson(json)).toList();
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
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Angkatan / Batches')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $_error', style: const TextStyle(color: Colors.red)),
            ElevatedButton(onPressed: _fetchBatches, child: Text('Retry')),
          ],
        ),
      );
    }
    if (_batches.isEmpty) {
      return Center(child: Text('No batches available.'));
    }
    return ListView.builder(
      itemCount: _batches.length,
      itemBuilder: (context, index) {
        final batch = _batches[index];
        return ListTile(
          title: Text(batch.name),
          subtitle: Text('ID: ${batch.id}'),
        );
      },
    );
  }
}
