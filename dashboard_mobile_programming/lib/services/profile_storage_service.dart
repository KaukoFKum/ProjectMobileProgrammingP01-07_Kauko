import 'package:shared_preferences/shared_preferences.dart';
import '../models/profile_model.dart';

class ProfileStorageService {
  static const String keyName = "profile_name";
  static const String keyHeadline = "profile_headline";
  static const String keyLocation = "profile_location";
  static const String keyEmail = "profile_email";
  static const String keyPhone = "profile_phone";
  static const String keyAbout = "profile_about";
  static const String keyExperience = "profile_experience";
  static const String keySkills = "profile_skills";
  static const String keyImagePath = "profile_image_path";

  static Future<void> saveProfile(ProfileModel profile) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(keyName, profile.name);
    await prefs.setString(keyHeadline, profile.headline);
    await prefs.setString(keyLocation, profile.location);
    await prefs.setString(keyEmail, profile.email);
    await prefs.setString(keyPhone, profile.phone);
    await prefs.setString(keyAbout, profile.about);
    await prefs.setString(keyExperience, profile.experience);
    await prefs.setString(keySkills, profile.skills);
    await prefs.setString(keyImagePath, profile.imagePath);
  }

  static Future<ProfileModel> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();

    final hasProfile = prefs.containsKey(keyName);

    if (!hasProfile) {
      return ProfileModel.defaultProfile();
    }

    return ProfileModel(
      name: prefs.getString(keyName) ?? "",
      headline: prefs.getString(keyHeadline) ?? "",
      location: prefs.getString(keyLocation) ?? "",
      email: prefs.getString(keyEmail) ?? "",
      phone: prefs.getString(keyPhone) ?? "",
      about: prefs.getString(keyAbout) ?? "",
      experience: prefs.getString(keyExperience) ?? "",
      skills: prefs.getString(keySkills) ?? "",
      imagePath: prefs.getString(keyImagePath) ?? "",
    );
  }

  static Future<void> clearProfile() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(keyName);
    await prefs.remove(keyHeadline);
    await prefs.remove(keyLocation);
    await prefs.remove(keyEmail);
    await prefs.remove(keyPhone);
    await prefs.remove(keyAbout);
    await prefs.remove(keyExperience);
    await prefs.remove(keySkills);
    await prefs.remove(keyImagePath);
  }
}