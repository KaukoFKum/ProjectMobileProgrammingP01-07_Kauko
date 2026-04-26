import 'package:flutter/material.dart';
import 'lab_template_page.dart';

class Pertemuan1Page extends StatefulWidget {
  const Pertemuan1Page({super.key});

  @override
  State<Pertemuan1Page> createState() => _Pertemuan1PageState();
}

class _Pertemuan1PageState extends State<Pertemuan1Page> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return LabTemplatePage(
      title: "Pertemuan 1",
      subtitle: "Pengenalan Flutter, struktur project, widget, dan state sederhana.",
      icon: Icons.mobile_friendly,
      color: Colors.blue,
      child: Column(
        children: [
          const Text(
            "Latihan Counter",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            "Tekan tombol untuk memahami perubahan state menggunakan setState().",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54, height: 1.5),
          ),
          const SizedBox(height: 24),
          Text(
            "$counter",
            style: const TextStyle(
              fontSize: 58,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                counter++;
              });
            },
            icon: const Icon(Icons.add),
            label: const Text("Tambah Counter"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            ),
          ),
        ],
      ),
    );
  }
}