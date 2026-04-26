import 'package:flutter/material.dart';
import 'lab_template_page.dart';

class Pertemuan2Page extends StatefulWidget {
  const Pertemuan2Page({super.key});

  @override
  State<Pertemuan2Page> createState() => _Pertemuan2PageState();
}

class _Pertemuan2PageState extends State<Pertemuan2Page> {
  String message = "Belum ada tombol diklik";

  @override
  Widget build(BuildContext context) {
    return LabTemplatePage(
      title: "Pertemuan 2",
      subtitle: "Latihan penggunaan widget dasar dan button untuk interaksi user.",
      icon: Icons.smart_button_outlined,
      color: Colors.green,
      child: Column(
        children: [
          const Text(
            "Latihan Widget & Button",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.08),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                message = "Button berhasil diklik!";
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Button diklik")),
              );
            },
            icon: const Icon(Icons.touch_app),
            label: const Text("Klik Saya"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            ),
          ),
        ],
      ),
    );
  }
}