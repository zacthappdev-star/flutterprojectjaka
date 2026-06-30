import 'package:flutter/material.dart';

import '../models/training_model.dart';
import '../services/api_services.dart';
import 'training_detail_screen.dart';

class TrainingsScreen extends StatefulWidget {
  const TrainingsScreen({super.key});

  @override
  State<TrainingsScreen> createState() => _TrainingsScreenState();
}

class _TrainingsScreenState extends State<TrainingsScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<TrainingModel>> _trainingsFuture;

  @override
  void initState() {
    super.initState();
    _trainingsFuture = _fetchTrainings();
  }

  Future<List<TrainingModel>> _fetchTrainings() async {
    final response = await _apiService.getTrainings();
    final List data = response.data['data'];
    return data.map((json) => TrainingModel.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TrainingModel>>(
      future: _trainingsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _trainingsFuture = _fetchTrainings();
                    });
                  },
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
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.school_outlined,
                  size: 80,
                  color: Colors.grey.shade300,
                ),
                SizedBox(height: 16),
                Text(
                  'Belum ada pelatihan.',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                ),
              ],
            ),
          );
        }

        final trainings = snapshot.data!;
        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          itemCount: trainings.length,
          itemBuilder: (context, index) {
            final training = trainings[index];
            return Card(
              elevation: 4,
              shadowColor: Colors.black12,
              margin: EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                leading: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(Icons.school, color: Colors.blue.shade700),
                ),
                title: Text(
                  training.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 6.0),
                  child: Text(
                    'ID: ${training.id} • ${training.duration ?? 0} Jam',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
                trailing: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.blue.shade400,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TrainingDetailScreen(id: training.id),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
