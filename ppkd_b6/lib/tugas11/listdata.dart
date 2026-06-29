import 'package:flutter/material.dart';

import 'database.dart';
import 'model.dart';

class ListDataPage extends StatefulWidget {
  const ListDataPage({super.key});

  @override
  State<ListDataPage> createState() => _ListDataPageState();
}

class _ListDataPageState extends State<ListDataPage> {
  Future<void> editPeserta(Peserta peserta) async {
    TextEditingController namaController = TextEditingController(
      text: peserta.nama,
    );

    TextEditingController emailController = TextEditingController(
      text: peserta.email,
    );

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Data"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: namaController,
                decoration: const InputDecoration(labelText: "Nama"),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () async {
                Peserta dataBaru = Peserta(
                  id: peserta.id,
                  nama: namaController.text,
                  email: emailController.text,
                  password: peserta.password,
                );
                await DatabaseHelper.instance.updatePeserta(dataBaru);
                if (!context.mounted) return;
                Navigator.pop(context);

                setState(() {});
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  Future<void> hapusPeserta(Peserta peserta) async {
    bool? hapus = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Hapus Data"),
          content: const Text("Yakin ingin menghapus data ini?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Hapus"),
            ),
          ],
        );
      },
    );

    if (hapus == true) {
      await DatabaseHelper.instance.deletePeserta(peserta.id!);

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Peserta"),
        backgroundColor: Colors.green,
      ),

      body: FutureBuilder<List<Peserta>>(
        future: DatabaseHelper.instance.getPeserta(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada data"));
          }

          final data = snapshot.data!;

          return ListView.builder(
            itemCount: data.length,

            itemBuilder: (context, index) {
              final peserta = data[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),

                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Text(
                      peserta.nama[0].toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),

                  title: Text(peserta.nama),

                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(peserta.email),
                      Text(peserta.nomorHp ?? "-"),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          editPeserta(peserta);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          hapusPeserta(peserta);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
