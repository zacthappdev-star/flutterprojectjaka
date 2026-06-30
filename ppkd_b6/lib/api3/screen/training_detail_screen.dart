import 'package:flutter/material.dart';

import '../models/training_model.dart';
import '../services/api_services.dart';

class TrainingDetailScreen extends StatefulWidget {
  final int id;
  const TrainingDetailScreen({super.key, required this.id});

  @override
  State<TrainingDetailScreen> createState() => _TrainingDetailScreenState();
}

class _TrainingDetailScreenState extends State<TrainingDetailScreen> {
  final ApiService _apiService = ApiService();
  TrainingModel? _training;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchTrainingDetail();
  }

  Future<void> _fetchTrainingDetail() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final response = await _apiService.getTrainingById(widget.id);
      final data = response.data['data'];
      if (mounted) {
        setState(() {
          _training = TrainingModel.fromJson(data);
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
      appBar: AppBar(title: Text('Detail Pelatihan')),
      body: _buildBody(),
    );
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
            ElevatedButton(
              onPressed: _fetchTrainingDetail,
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }
    if (_training == null) {
      return Center(child: Text('Data not found.'));
    }
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text(
          _training!.title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(height: 16),
        Text('Deskripsi: ${_training!.description ?? '-'}'),
        SizedBox(height: 8),
        Text('Jumlah Peserta: ${_training!.participantCount ?? '-'}'),
        SizedBox(height: 8),
        Text('Standar: ${_training!.standard ?? '-'}'),
        SizedBox(height: 8),
        Text('Durasi: ${_training!.duration ?? '-'} jam'),
      ],
    );
  }
}
