import 'package:flutter/material.dart';

class ScaffoldDay5 extends StatelessWidget {
  const ScaffoldDay5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [Text("Keluar")],
        title: Text("DukunSaldo"),
        backgroundColor: Colors.white,
        shadowColor: Colors.black38,
        elevation: 4,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(Icons.notification_add_rounded),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: 130,
              decoration: BoxDecoration(
                color: Colors.grey[350],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(1, 1),
                    blurStyle: BlurStyle.outer,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    margin: EdgeInsets.fromLTRB(20, 0, 10, 30),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        // Masukkan link gambar dari internet di dalam tanda kutip
                        image: AssetImage("assets/images/icon.jpg"),
                        fit: BoxFit.cover,
                        // Memastikan gambar menutupi seluruh area lingkaran tanpa gepeng
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Atio Wahyudi Saputra",
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          "Developer Mandiri",
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          "Cilincing, Jakarta",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // card1
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              height: 230,
              margin: EdgeInsets.only(top: 0),

              child: Container(
                margin: EdgeInsets.only(top: 0),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(blurRadius: 5)],
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Detail Kontak",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ), // Memberikan jarak antara judul dan isi
                        // --- IMPLEMENTASI POIN 3: Detail Kontak ---
                        // Gunakan Row berisi Icon dan Text, wajib menyisipkan SizedBox
                        Row(
                          children: [
                            Icon(Icons.email),
                            SizedBox(
                              width: 10,
                            ), // SizedBox sebagai jarak antara Icon dan Text
                            Text(
                              "aws@jaya.com", // Disesuaikan dengan contoh logika output
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),

                        SizedBox(height: 12), // Jarak vertikal antar baris
                        // --- IMPLEMENTASI POIN 4: Informasi Pendukung ---
                        // Gunakan Row, dan gunakan widget Spacer untuk rata kanan otomatis
                        Row(
                          children: [
                            Icon(Icons.phone, size: 20),
                            SizedBox(width: 10),
                            Text("0812-xxxx", style: TextStyle(fontSize: 16)),
                            Spacer(), // Spacer akan mendorong elemen setelahnya ke ujung kanan
                            Icon(Icons.location_on, size: 20),
                            SizedBox(width: 4),
                            Text(
                              "Jakarta Pusat",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // section 2
          ],
        ),
      ),
    );
  }
}