import 'package:flutter/material.dart';
import 'lab_template_page.dart';

class Pertemuan4Page extends StatelessWidget {
  const Pertemuan4Page({super.key});

  void _showDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Apakah Anda yakin ingin menampilkan pesan?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tidak"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Anda memilih YA")),
              );
            },
            child: const Text("Ya"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LabTemplatePage(
      title: "Pertemuan 4",
      subtitle: "Latihan AlertDialog dan notifikasi sederhana.",
      icon: Icons.notifications_active_outlined,
      color: Colors.redAccent,
      child: Column(
        children: [
          const Text(
            "Latihan AlertDialog",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            "Tekan tombol untuk menampilkan dialog konfirmasi.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54, height: 1.5),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _showDialogBox(context),
            icon: const Icon(Icons.warning_amber_rounded),
            label: const Text("Tampilkan Dialog"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            ),
          ),
        ],
      ),
    );
  }
}