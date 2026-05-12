import 'package:flutter/material.dart';

class HiKata extends StatelessWidget {
  const HiKata({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("HI KATA"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // JARAK ATAS
            const SizedBox(height: 30),

            // NAMA / IDENTITAS
            const Center(
              child: Text(
                "JAKA AGUS DERMAWAN",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // EMAIL
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.all(13),

              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),

              child: const Row(
                children: [
                  Icon(Icons.email, color: Colors.black54),

                  SizedBox(width: 16),

                  Text("zachtappdev@gmail.com", style: TextStyle(fontSize: 15)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // TELEPON DAN LOKASI
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),

              child: Row(
                children: [
                  Icon(Icons.phone, size: 18),

                  SizedBox(width: 10),

                  Text("0851-xxxx-xxxx"),

                  Spacer(),

                  Icon(Icons.location_city, size: 18),

                  SizedBox(width: 11),

                  Text("JAKARTA"),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // STATISTIK
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),

              child: Row(
                children: [
                  // BOX 1
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: const Column(
                        children: [
                          Icon(Icons.menu_book, size: 35, color: Colors.green),

                          SizedBox(height: 10),

                          Text(
                            "120+",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text("Materi"),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  // BOX 2
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(
                        color: Colors.lightGreen.shade100,
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: const Column(
                        children: [
                          Icon(Icons.star, size: 35, color: Colors.orange),

                          SizedBox(height: 10),

                          Text(
                            "4.9",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text("Rating"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // DESKRIPSI
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),

              child: Text(
                "HI KATA adalah aplikasi pembelajaran bahasa Jepang "
                "yang membantu pengguna mempelajari huruf Hiragana dan Katakana "
                "dengan tampilan sederhana dan mudah digunakan untuk pemula. ",

                style: TextStyle(fontSize: 16, height: 1.5),

                textAlign: TextAlign.start,
              ),
            ),

            const SizedBox(height: 30),

            // VISUAL BRANDING
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 22),
              height: 180,
              width: double.infinity,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage("assets/images/Japan.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
