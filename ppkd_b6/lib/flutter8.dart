import 'package:flutter/material.dart';

class Navigator8 extends StatefulWidget {
  const Navigator8({super.key});

  @override
  State<Navigator8> createState() => _Navigator8State();
}

class _Navigator8State extends State<Navigator8> {
  final _formKey = GlobalKey<FormState>();
  String? selectedLevel;
  String? selectedKategori;
  bool isChecked = false;
  bool isDarkMode = false;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  int _currentIndex = 0;
  final List<String> _titles = ["HI KATA", "Tentang Aplikasi"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _titles[_currentIndex],
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      drawer: _currentIndex == 0
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: Colors.green),
                    child: Center(
                      child: Text(
                        "MENU",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.language),
                    title: Text("Hiragana"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.translate),
                    title: Text("Katakana"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.quiz),
                    title: Text("Quiz"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.bar_chart),
                    title: Text("Progress"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.alarm),
                    title: Text("Pengingat"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            )
          : null,
      body: _currentIndex == 0
          ? SingleChildScrollView(
              child: Container(
                width: double.infinity,
                color: isDarkMode ? Colors.black : Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
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
                        SizedBox(height: 10),
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
                              borderSide: BorderSide(color: Colors.green),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Nama Tidak Boleh Kosong";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 5),
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
                        SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          initialValue: selectedLevel,
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
                              borderSide: BorderSide(color: Colors.green),
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: "Pemula",
                              child: Text("Pemula"),
                            ),
                            DropdownMenuItem(
                              value: "Menengah",
                              child: Text("Menengah"),
                            ),
                            DropdownMenuItem(
                              value: "Expert",
                              child: Text("Expert"),
                            ),
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
                        SizedBox(height: 10),
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
                        SizedBox(height: 20),
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
                        SizedBox(height: 10),
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
                              borderSide: BorderSide(color: Colors.green),
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: "Hiragana",
                              child: Text("Hiragana"),
                            ),
                            DropdownMenuItem(
                              value: "Katakana",
                              child: Text("Katakana"),
                            ),
                            DropdownMenuItem(
                              value: "Quiz",
                              child: Text("Quiz"),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedKategori = value;
                            });
                          },
                        ),
                        SizedBox(height: 10),
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
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2050),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                selectedDate = pickedDate;
                              });
                            }
                          },
                          child: Text("Pilih Tanggal"),
                        ),
                        SizedBox(height: 5),
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
                        SizedBox(height: 5),
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
                          child: Text("Atur Pengingat"),
                        ),
                        SizedBox(height: 10),
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
                        SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
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
                            child: Text(
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
            )
          : Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "HI KATA",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "HI KATA adalah aplikasi "
                    "pembelajaran Hiragana dan "
                    "Katakana.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "Tentang"),
        ],
      ),
    );
  }
}
