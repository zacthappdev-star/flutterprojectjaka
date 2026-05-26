import 'package:flutter/material.dart';

void main() {
  runApp(const Profil());
}

class Profil extends StatelessWidget {
  const Profil({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profil Saya',
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Saya'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),

      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Jaka Agus Dermawan',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on, color: Colors.red),
                SizedBox(width: 8),
                Text('Jakarta, Indonesia', style: TextStyle(fontSize: 15)),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Saya adalah seorang peserta pelatihan yang sedang mendalami Flutter di PPKD.',
              style: TextStyle(fontSize: 16, color: Colors.black, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
