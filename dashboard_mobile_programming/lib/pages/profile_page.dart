import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/profile_model.dart';
import '../services/profile_storage_service.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  ProfileModel? profile;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    loadProfile();
  }

  Future<void> loadProfile() async {
    final data = await ProfileStorageService.loadProfile();

    setState(() {
      profile = data;
    });

    _animationController.forward(from: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  ImageProvider? _getProfileImage() {
    if (profile == null || profile!.imagePath.isEmpty) return null;

    if (kIsWeb) {
      return NetworkImage(profile!.imagePath);
    } else {
      return FileImage(File(profile!.imagePath));
    }
  }

  void _copyToClipboard(String label, String value) {
    Clipboard.setData(ClipboardData(text: value));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$label berhasil disalin"),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (profile == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      body: RefreshIndicator(
        onRefresh: loadProfile,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildAboutCard(),
                _buildExperienceCard(),
                _buildSkillsCard(),
                _buildContactCard(),
                const SizedBox(height: 20),
                _buildEditButton(),
                const SizedBox(height: 34),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 42, 20, 28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.blueAccent, Colors.lightBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(34),
          bottomRight: Radius.circular(34),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.24),
            blurRadius: 22,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.20),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 58,
              backgroundColor: const Color(0xffEAF2FF),
              backgroundImage: _getProfileImage(),
              child: profile!.imagePath.isEmpty
                  ? const Icon(
                      Icons.person,
                      size: 58,
                      color: Colors.blueAccent,
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            profile!.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.20),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.16)),
            ),
            child: Text(
              profile!.headline,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Colors.white70,
                size: 18,
              ),
              const SizedBox(width: 4),
              Text(
                profile!.location,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAboutCard() {
    return _buildSectionCard(
      icon: Icons.info_outline,
      title: "Tentang Saya",
      child: Text(
        profile!.about,
        style: const TextStyle(
          fontSize: 14.5,
          height: 1.7,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildExperienceCard() {
    return _buildSectionCard(
      icon: Icons.timeline_outlined,
      title: "Pengalaman",
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.10),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.work_outline,
              color: Colors.blueAccent,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              profile!.experience,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsCard() {
    final skills = profile!.skills
        .split(',')
        .map((skill) => skill.trim())
        .where((skill) => skill.isNotEmpty)
        .toList();

    return _buildSectionCard(
      icon: Icons.star_outline,
      title: "Keahlian",
      child: Wrap(
        spacing: 9,
        runSpacing: 9,
        children: skills.map((skill) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.09),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.blueAccent.withOpacity(0.18),
              ),
            ),
            child: Text(
              skill,
              style: const TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w600,
                fontSize: 12.5,
                letterSpacing: 0.2,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildContactCard() {
    return _buildSectionCard(
      icon: Icons.contact_mail_outlined,
      title: "Kontak",
      child: Column(
        children: [
          _buildContactTile(
            icon: Icons.email_outlined,
            title: "Email",
            value: profile!.email,
          ),
          const Divider(height: 24, thickness: 0.5),
          _buildContactTile(
            icon: Icons.phone_outlined,
            title: "No HP",
            value: profile!.phone,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.060),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Colors.blueAccent,
                  size: 21,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildContactTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        hoverColor: Colors.blueAccent.withOpacity(0.05),
        splashColor: Colors.blueAccent.withOpacity(0.08),
        highlightColor: Colors.blueAccent.withOpacity(0.04),
        onTap: () => _copyToClipboard(title, value),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.09),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  icon,
                  color: Colors.blueAccent,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      value,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.copy_outlined,
                color: Colors.black38,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton.icon(
        onPressed: () async {
          await Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => EditProfilePage(profile: profile!),
              transitionsBuilder: (_, animation, __, child) {
                final slide = Tween<Offset>(
                  begin: const Offset(0.08, 0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  ),
                );

                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: slide,
                    child: child,
                  ),
                );
              },
            ),
          );
          loadProfile();
        },
        icon: const Icon(Icons.edit_outlined),
        label: const Text("Edit Profile"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          elevation: 6,
          shadowColor: Colors.blueAccent.withOpacity(0.35),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: const StadiumBorder(),
        ),
      ),
    );
  }
}