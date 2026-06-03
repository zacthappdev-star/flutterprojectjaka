import 'package:flutter/material.dart';
import 'package:ppkd_b6/local/database/preference_handler.dart';
import 'package:ppkd_b6/loginn.dart';

class Navigator7 extends StatefulWidget {
  const Navigator7({super.key});

  @override
  State<Navigator7> createState() => _Navigator7State();
}

class _Navigator7State extends State<Navigator7> {
  final _formKey = GlobalKey<FormState>();
  String? selectedLevel;
  String? selectedKategori;
  bool isChecked = false;
  bool isDarkMode = false;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  void _logOut() async {
    await Preference.clearAll();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const TampilanLogin()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String userEmail = args?['email'] ?? "Guest";
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "HI KATA",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.green),
              child: Center(
                child: Text(
                  userEmail,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text("Hiragana"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.translate),
              title: const Text("Katakana"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.quiz),
              title: const Text("Quiz"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text("Progress"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.alarm),
              title: const Text("Pengingat"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: _logOut,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: isDarkMode ? Colors.black : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Biodata",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: "Masukkan Nama",
                      hintStyle: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 13,
                      ),
                      prefixIcon: Icon(
                        Icons.person_2_rounded,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      filled: true,
                      fillColor: isDarkMode
                          ? Colors.grey.shade900
                          : Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.green,
                          width: 2,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Nama Tidak Boleh Kosong";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: Text(
                      "Level",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    initialValue:
                        selectedLevel, // Diubah dari initialValue ke value agar aman saat state berubah
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: 16,
                    ),
                    dropdownColor: isDarkMode
                        ? Colors.grey.shade900
                        : Colors.white,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.school,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      filled: true,
                      fillColor: isDarkMode
                          ? Colors.grey.shade900
                          : Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.green,
                          width: 2,
                        ),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(value: "Pemula", child: Text("Pemula")),
                      DropdownMenuItem(
                        value: "Menengah",
                        child: Text("Menengah"),
                      ),
                      DropdownMenuItem(value: "Expert", child: Text("Expert")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedLevel = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Level harus dipilih";
                      }
                      return null;
                    },
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.trailing,
                    title: Text(
                      "Sudah yakin ?",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      isChecked
                          ? "Pendaftaran disetujui"
                          : "Pendaftaran belum ada",
                      style: TextStyle(
                        fontSize: 15,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SwitchListTile(
                    title: Text(
                      "Mode Gelap",
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    value: isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        isDarkMode = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Pembelajaran",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    initialValue: selectedKategori,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: 16,
                    ),
                    dropdownColor: isDarkMode
                        ? Colors.grey.shade900
                        : Colors.white,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.category,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      filled: true,
                      fillColor: isDarkMode
                          ? Colors.grey.shade900
                          : Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.green,
                          width: 2,
                        ),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: "Hiragana",
                        child: Text("Hiragana"),
                      ),
                      DropdownMenuItem(
                        value: "Katakana",
                        child: Text("Katakana"),
                      ),
                      DropdownMenuItem(value: "Quiz", child: Text("Quiz")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedKategori = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      selectedKategori == null
                          ? "Belum memilih kategori"
                          : "Anda memilih kategori: $selectedKategori",
                      style: TextStyle(
                        fontSize: 13,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    child: const Text("Pilih Tanggal"),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    selectedDate == null
                        ? "Tanggal belum dipilih"
                        : "Tanggal Lahir: "
                              "${selectedDate!.day.toString().padLeft(2, '0')}-"
                              "${selectedDate!.month.toString().padLeft(2, '0')}-"
                              "${selectedDate!.year}",
                    style: TextStyle(
                      fontSize: 16,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          selectedTime = pickedTime;
                        });
                      }
                    },
                    child: const Text("Atur Pengingat"),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    selectedTime == null
                        ? "Pengingat belum diatur"
                        : "Pengingat diatur pukul: "
                              "${selectedTime!.hour.toString().padLeft(2, '0')}:"
                              "${selectedTime!.minute.toString().padLeft(2, '0')}",
                    style: TextStyle(
                      fontSize: 16,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Data berhasil disimpan"),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "Simpan",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
