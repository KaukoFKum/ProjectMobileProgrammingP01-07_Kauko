import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import '../models/profile_model.dart';
import '../services/profile_storage_service.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileModel profile;

  const EditProfilePage({
    super.key,
    required this.profile,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController headlineController;
  late TextEditingController locationController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController aboutController;
  late TextEditingController experienceController;
  late TextEditingController skillsController;

  String imagePath = "";

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.profile.name);
    headlineController = TextEditingController(text: widget.profile.headline);
    locationController = TextEditingController(text: widget.profile.location);
    emailController = TextEditingController(text: widget.profile.email);
    phoneController = TextEditingController(text: widget.profile.phone);
    aboutController = TextEditingController(text: widget.profile.about);
    experienceController =
        TextEditingController(text: widget.profile.experience);
    skillsController = TextEditingController(text: widget.profile.skills);
    imagePath = widget.profile.imagePath;
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        imagePath = image.path;
      });
    }
  }

  Future<void> saveProfile() async {
    final updatedProfile = ProfileModel(
      name: nameController.text.trim(),
      headline: headlineController.text.trim(),
      location: locationController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      about: aboutController.text.trim(),
      experience: experienceController.text.trim(),
      skills: skillsController.text.trim(),
      imagePath: imagePath,
    );

    await ProfileStorageService.saveProfile(updatedProfile);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Profile berhasil disimpan"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    nameController.dispose();
    headlineController.dispose();
    locationController.dispose();
    emailController.dispose();
    phoneController.dispose();
    aboutController.dispose();
    experienceController.dispose();
    skillsController.dispose();
    super.dispose();
  }

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: const Color(0xffF8FAFD),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget buildPhotoPreview() {
    return Column(
      children: [
        CircleAvatar(
          radius: 58,
          backgroundColor: Colors.white,
          child: imagePath.isEmpty
            ? const Icon(
                Icons.person,
                size: 54,
                color: Colors.blueAccent,
              )
            : ClipOval(
                child: kIsWeb
                    ? Image.network(
                        imagePath,
                        width: 116,
                        height: 116,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(imagePath),
                        width: 116,
                        height: 116,
                        fit: BoxFit.cover,
                      ),
              ),
      ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: pickImage,
          icon: const Icon(Icons.photo_camera_outlined),
          label: const Text("Upload Foto Profil"),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 28, 16, 26),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: buildPhotoPreview(),
          ),
          const SizedBox(height: 18),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.12),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                buildTextField(
                  label: "Nama Lengkap",
                  controller: nameController,
                  icon: Icons.badge_outlined,
                ),
                buildTextField(
                  label: "Headline / Jabatan",
                  controller: headlineController,
                  icon: Icons.work_outline,
                ),
                buildTextField(
                  label: "Lokasi",
                  controller: locationController,
                  icon: Icons.location_on_outlined,
                ),
                buildTextField(
                  label: "Email",
                  controller: emailController,
                  icon: Icons.email_outlined,
                ),
                buildTextField(
                  label: "No HP",
                  controller: phoneController,
                  icon: Icons.phone_outlined,
                ),
                buildTextField(
                  label: "Tentang Saya",
                  controller: aboutController,
                  icon: Icons.info_outline,
                  maxLines: 4,
                ),
                buildTextField(
                  label: "Pengalaman",
                  controller: experienceController,
                  icon: Icons.timeline,
                ),
                buildTextField(
                  label: "Keahlian",
                  controller: skillsController,
                  icon: Icons.star_outline,
                  maxLines: 2,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: saveProfile,
                    icon: const Icon(Icons.save_outlined),
                    label: const Text("Simpan Profile"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}