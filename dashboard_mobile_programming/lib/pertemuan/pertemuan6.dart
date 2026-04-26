import 'package:flutter/material.dart';

class Pertemuan6Page extends StatefulWidget {
  const Pertemuan6Page({super.key});

  @override
  State<Pertemuan6Page> createState() => _Pertemuan6PageState();
}

class _Pertemuan6PageState extends State<Pertemuan6Page> {
  bool flutterChecked = false;
  bool dartChecked = false;
  bool firebaseChecked = false;
  bool? triStateValue = false;

  void _showResult() {
    List<String> pilihan = [];

    if (flutterChecked) pilihan.add("Flutter");
    if (dartChecked) pilihan.add("Dart");
    if (firebaseChecked) pilihan.add("Firebase");

    String triStateText;
    if (triStateValue == true) {
      triStateText = "Checked";
    } else if (triStateValue == false) {
      triStateText = "Unchecked";
    } else {
      triStateText = "Indeterminate";
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Hasil Pilihan"),
        content: Text(
          pilihan.isEmpty
              ? "Belum ada teknologi yang dipilih.\n\nTri-State: $triStateText"
              : "Teknologi dipilih:\n- ${pilihan.join("\n- ")}\n\nTri-State: $triStateText",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup"),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required Function(bool?) onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: CheckboxListTile(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.blueAccent,
        secondary: Icon(icon, color: Colors.blueAccent),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle),
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        title: const Text("Pertemuan 6 - Checkbox"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Latihan Checkbox",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Pilih teknologi yang ingin dipelajari. Checkbox dapat memilih lebih dari satu opsi.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),

            _buildCheckboxCard(
              title: "Flutter",
              subtitle: "Framework UI untuk aplikasi mobile, web, dan desktop",
              icon: Icons.phone_android,
              value: flutterChecked,
              onChanged: (value) {
                setState(() {
                  flutterChecked = value ?? false;
                });
              },
            ),
            _buildCheckboxCard(
              title: "Dart",
              subtitle: "Bahasa pemrograman utama untuk Flutter",
              icon: Icons.code,
              value: dartChecked,
              onChanged: (value) {
                setState(() {
                  dartChecked = value ?? false;
                });
              },
            ),
            _buildCheckboxCard(
              title: "Firebase",
              subtitle: "Backend service untuk autentikasi dan database",
              icon: Icons.cloud,
              value: firebaseChecked,
              onChanged: (value) {
                setState(() {
                  firebaseChecked = value ?? false;
                });
              },
            ),

            const SizedBox(height: 18),
            const Text(
              "Tri-State Checkbox",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: CheckboxListTile(
                tristate: true,
                value: triStateValue,
                activeColor: Colors.blueAccent,
                secondary: const Icon(Icons.check_box, color: Colors.blueAccent),
                title: const Text("Status Persetujuan"),
                subtitle: Text(
                  triStateValue == true
                      ? "Checked"
                      : triStateValue == false
                          ? "Unchecked"
                          : "Indeterminate",
                ),
                onChanged: (value) {
                  setState(() {
                    triStateValue = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _showResult,
                icon: const Icon(Icons.visibility),
                label: const Text("Tampilkan Hasil"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}