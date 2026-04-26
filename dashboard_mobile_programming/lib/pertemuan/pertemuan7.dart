import 'package:flutter/material.dart';
import 'lab_template_page.dart';

class Pertemuan7Page extends StatefulWidget {
  const Pertemuan7Page({super.key});

  @override
  State<Pertemuan7Page> createState() => _Pertemuan7PageState();
}

class _Pertemuan7PageState extends State<Pertemuan7Page> {
  String? selectedLanguage;

  final List<String> languages = [
    "Flutter",
    "Dart",
    "Java",
    "Kotlin",
    "Swift",
    "Python",
    "PHP",
  ];

  void _showMessage(String value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Anda memilih $value"),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.indigo,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LabTemplatePage(
      title: "Pertemuan 7",
      subtitle:
          "Latihan RadioButton untuk memilih satu opsi dari beberapa pilihan.",
      icon: Icons.radio_button_checked,
      color: Colors.indigo,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Daftar Pilihan Bahasa Pemrograman",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Pilih salah satu bahasa pemrograman. Ketika satu pilihan dipilih, pilihan lainnya otomatis tidak aktif.",
            style: TextStyle(
              color: Colors.black54,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),

          ListView.builder(
            itemCount: languages.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = languages[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: selectedLanguage == item
                      ? Colors.indigo.withOpacity(0.10)
                      : Colors.grey.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: selectedLanguage == item
                        ? Colors.indigo
                        : Colors.transparent,
                    width: 1.2,
                  ),
                ),
                child: RadioListTile<String>(
                  value: item,
                  groupValue: selectedLanguage,
                  activeColor: Colors.indigo,
                  title: Text(
                    item,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: selectedLanguage == item
                          ? Colors.indigo
                          : Colors.black87,
                    ),
                  ),
                  subtitle: Text("Pilihan bahasa: $item"),
                  secondary: Icon(
                    Icons.code,
                    color: selectedLanguage == item
                        ? Colors.indigo
                        : Colors.black45,
                  ),
                  onChanged: (value) {
                    setState(() {
                      selectedLanguage = value;
                    });

                    if (value != null) {
                      _showMessage(value);
                    }
                  },
                ),
              );
            },
          ),

          const SizedBox(height: 18),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.indigo.withOpacity(0.06),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              selectedLanguage == null
                  ? "Belum ada pilihan."
                  : "Pilihan saat ini: $selectedLanguage",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.indigo,
              ),
            ),
          ),
        ],
      ),
    );
  }
}