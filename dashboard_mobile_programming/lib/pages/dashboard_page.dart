import 'package:flutter/material.dart';
//import '../pertemuan/pertemuan_detail_page.dart';
import '../pertemuan/pertemuan1.dart';
import '../pertemuan/pertemuan2.dart';
import '../pertemuan/pertemuan3.dart';
import '../pertemuan/pertemuan4.dart';
import '../pertemuan/pertemuan5.dart';
import '../pertemuan/pertemuan6.dart';
import '../pertemuan/pertemuan7.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        "title": "Pertemuan 1",
        "icon": Icons.mobile_friendly,
        "color": Colors.blue,
        "desc": "Pengenalan Android dan Flutter"
      },
      {
        "title": "Pertemuan 2",
        "icon": Icons.smart_button,
        "color": Colors.green,
        "desc": "Widget dan Button"
      },
      {
        "title": "Pertemuan 3",
        "icon": Icons.open_in_new,
        "color": Colors.orange,
        "desc": "Activity dan Intent"
      },
      {
        "title": "Pertemuan 4",
        "icon": Icons.notifications,
        "color": Colors.red,
        "desc": "Toast dan AlertDialog"
      },
      {
        "title": "Pertemuan 5",
        "icon": Icons.list,
        "color": Colors.purple,
        "desc": "ListView"
      },
      {
        "title": "Pertemuan 6",
        "icon": Icons.check_box,
        "color": Colors.teal,
        "desc": "Checkbox"
      },
      {
        "title": "Pertemuan 7",
        "icon": Icons.radio_button_checked,
        "color": Colors.indigo,
        "desc": "Radio Button"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Mobile Programming"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: menuItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 kolom
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final item = menuItems[index];

            return GestureDetector(
              onTap: () {
                Widget targetPage;

                switch (item['title']) {
                  case "Pertemuan 1":
                    targetPage = const Pertemuan1Page();
                    break;
                  case "Pertemuan 2":
                    targetPage = const Pertemuan2Page();
                    break;
                  case "Pertemuan 3":
                    targetPage = const Pertemuan3Page();
                    break;
                  case "Pertemuan 4":
                    targetPage = const Pertemuan4Page();
                    break;
                  case "Pertemuan 5":
                    targetPage = const Pertemuan5Page();
                    break;
                  case "Pertemuan 6":
                    targetPage = const Pertemuan6Page();
                    break;
                  case "Pertemuan 7":
                    targetPage = const Pertemuan7Page();
                    break;  
                  default:
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Halaman belum tersedia")),
                    );
                    return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => targetPage),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      item["color"],
                      item["color"].withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: item["color"].withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item["icon"],
                      size: 48,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item["title"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}