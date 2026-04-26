class ProfileModel {
  final String name;
  final String headline;
  final String location;
  final String email;
  final String phone;
  final String about;
  final String experience;
  final String skills;
  final String imagePath;

  ProfileModel({
    required this.name,
    required this.headline,
    required this.location,
    required this.email,
    required this.phone,
    required this.about,
    required this.experience,
    required this.skills,
    required this.imagePath,
  });

  factory ProfileModel.defaultProfile() {
    return ProfileModel(
      name: "Kauko Fitra Kumaratama",
      headline: "Manager Core Datacomm Assurance Eastern Jabotabek",
      location: "Jakarta, Indonesia",
      email: "kauko@email.com",
      phone: "08124300043",
      about:
          "Profesional di bidang telekomunikasi yang berfokus pada reliability, operational excellence, dan pengembangan teknologi jaringan Core & Datacomm.",
      experience: "25 Tahun",
      skills: "Flutter, Mobile Programming, Telco Network, Core Datacomm",
      imagePath: "",
    );
  }

  Map<String, String> toMap() {
    return {
      "name": name,
      "headline": headline,
      "location": location,
      "email": email,
      "phone": phone,
      "about": about,
      "experience": experience,
      "skills": skills,
      "imagePath": imagePath,
    };
  }

  factory ProfileModel.fromMap(Map<String, String> map) {
    return ProfileModel(
      name: map["name"] ?? "",
      headline: map["headline"] ?? "",
      location: map["location"] ?? "",
      email: map["email"] ?? "",
      phone: map["phone"] ?? "",
      about: map["about"] ?? "",
      experience: map["experience"] ?? "",
      skills: map["skills"] ?? "",
      imagePath: map["imagePath"] ?? "",
    );
  }
}