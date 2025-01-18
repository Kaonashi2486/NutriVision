// lib/viewmodels/user_view_model.dart

class UserViewModel {
  String name;
  double height; // in centimeters
  double weight; // in kilograms
  int age;
  List<String> pastDiseases;

  // Constructor
  UserViewModel({
    required this.name,
    required this.height,
    required this.weight,
    required this.age,
    required this.pastDiseases,
  });

  // Method to calculate BMI
  double calculateBMI() {
    double heightInMeters = height / 100;
    return weight / (heightInMeters * heightInMeters);
  }

  // Method to determine if the BMI is healthy
  bool isHealthyBMI() {
    double bmi = calculateBMI();
    // Healthy BMI range is between 18.5 and 24.9
    return bmi >= 18.5 && bmi <= 24.9;
  }

  void updateUser({
    String? name,
    double? height,
    double? weight,
    int? age,
    List<String>? pastDiseases,
  }) {
    if (name != null) this.name = name;
    if (height != null) this.height = height;
    if (weight != null) this.weight = weight;
    if (age != null) this.age = age;
    if (pastDiseases != null) this.pastDiseases = pastDiseases;
  }
}
