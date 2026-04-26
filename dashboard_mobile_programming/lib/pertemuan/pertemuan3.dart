import 'package:flutter/material.dart';
import 'lab_template_page.dart';

class Pertemuan3Page extends StatelessWidget {
  const Pertemuan3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LabTemplatePage(
      title: "Pertemuan 3",
      subtitle: "Latihan navigation untuk berpindah halaman menggunakan Navigator.push().",
      icon: Icons.open_in_new,
      color: Colors.orange,
      child: Column(
        children: [
          const Text(
            "Latihan Navigation",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            "Klik tombol di bawah untuk membuka halaman kedua.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54, height: 1.5),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const HalamanKedua(),
                ),
              );
            },
            icon: const Icon(Icons.arrow_forward),
            label: const Text("Pindah Halaman"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class HalamanKedua extends StatelessWidget {
  const HalamanKedua({super.key});

  @override
  Widget build(BuildContext context) {
    return LabTemplatePage(
      title: "Halaman Kedua",
      subtitle: "Ini adalah hasil dari proses perpindahan halaman.",
      icon: Icons.check_circle_outline,
      color: Colors.orange,
      child: Column(
        children: [
          const Text(
            "Berhasil pindah halaman!",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
            label: const Text("Kembali"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}