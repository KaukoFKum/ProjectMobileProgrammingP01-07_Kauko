import 'package:flutter/material.dart';
import 'lab_template_page.dart';

class Pertemuan5Page extends StatelessWidget {
  const Pertemuan5Page({super.key});

  final List<String> data = const [
    "Flutter",
    "Dart",
    "Java",
    "Kotlin",
    "Swift",
    "PHP",
    "Python",
  ];

  @override
  Widget build(BuildContext context) {
    return LabTemplatePage(
      title: "Pertemuan 5",
      subtitle: "Latihan ListView.builder untuk menampilkan data dinamis.",
      icon: Icons.list_alt_rounded,
      color: Colors.purple,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Daftar Bahasa Pemrograman",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            "Klik salah satu item untuk menampilkan pesan.",
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 18),
          ListView.builder(
            itemCount: data.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.purple.withOpacity(0.15),
                    child: Text(
                      "${index + 1}",
                      style: const TextStyle(color: Colors.purple),
                    ),
                  ),
                  title: Text(
                    data[index],
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Anda memilih ${data[index]}")),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}