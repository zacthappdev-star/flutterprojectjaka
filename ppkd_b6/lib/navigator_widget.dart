import 'package:flutter/material.dart';

class NavigatorWidget extends StatefulWidget {
  const NavigatorWidget({super.key});

  @override
  State<NavigatorWidget> createState() => _NavigatorWidgetState();
}

class _NavigatorWidgetState extends State<NavigatorWidget> {
  final _formKey = GlobalKey<FormState>();
  String? selectedLevel;
  String? selectedKategori;
  bool isChecked = false;
  bool isDarkMode = false;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                Text(
                  "Biodata",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Masukkan Nama",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  initialValue: selectedLevel,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
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
                ),
                SizedBox(height: 20),
                CheckboxListTile(
                  title: Text("Sudah yakin?"),
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                SwitchListTile(
                  title: Text("Mode Gelap"),
                  value: isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      isDarkMode = value;
                    });
                  },
                ),
                SizedBox(height: 20),
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
                SizedBox(height: 10),
                Text(
                  selectedDate == null
                      ? "Tanggal belum dipilih"
                      : "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                ),
                SizedBox(height: 20),
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
                      : "${selectedTime!.hour}:${selectedTime!.minute}",
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Data berhasil disimpan")),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: Text("Simpan"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
