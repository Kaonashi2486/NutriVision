class UserViewModel {
  String name;
  String lName;
  String email;
  String password;
  String contactNumber;
  String address;
  String city;
  String role;
  DateTime createdAt;
  int? age;
  double? weight;
  double? height;
  String? gender;
  bool? isPregnant;
  Map<String, dynamic> healthIssues;
  List<String> allergies;
  String foodPreference;
  List<String> familymembers;
  List<String>? pastDiseases;
  // Constructor
  UserViewModel({
    required this.name,
    required this.lName,
    required this.email,
    required this.password,
    required this.contactNumber,
    required this.address,
    required this.city,
    required this.role,
    required this.createdAt,
    this.age,
    this.weight,
    this.height,
    this.gender,
    this.isPregnant,
    required this.healthIssues,
    required this.allergies,
    required this.foodPreference,
    required this.familymembers,
    this.pastDiseases,
  });

  double calculateBMI() {
    double heightInMeters = height ??150/ 100;
    return weight ??55 / (heightInMeters * heightInMeters);
  }

  // Method to determine if the BMI is healthy
  bool isHealthyBMI() {
    double bmi = calculateBMI();
    // Healthy BMI range is between 18.5 and 24.9
    return bmi >= 18.5 && bmi <= 24.9;
  }


  // Factory method to create an instance from JSON
  factory UserViewModel.fromJson(Map<String, dynamic> json) {
    return UserViewModel(
      name: json['name'] ?? '',
      lName: json['lName'] ?? '',
      email: (json['email'] ?? '').trim().toLowerCase(),
      password: json['password'] ?? '',
      contactNumber: json['contactNumber'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      role: 'customer', // Always set as "customer" per your requirements
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toString()),
      age: json['age'],
      weight: json['weight']?.toDouble(),
      height: json['height']?.toDouble(),
      gender: json['gender'],
      isPregnant: json['gender'] == 'female' ? json['isPregnant'] : null,
      healthIssues: Map<String, dynamic>.from(json['healthIssues'] ?? {}),
      allergies: List<String>.from(json['allergies'] ?? []),
      foodPreference: ['veg', 'non-veg', 'jain'].contains(json['foodPreference'])
          ? json['foodPreference']
          : 'veg', // Default to 'veg'
      familymembers: List<String>.from(json['familymembers'] ?? []),
      pastDiseases: List<String>.from(json['pastDiseases'] ?? []
    ));
  }



  // Method to convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lName': lName,
      'email': email,
      'password': password,
      'contactNumber': contactNumber,
      'address': address,
      'city': city,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
      'age': age,
      'weight': weight,
      'height': height,
      'gender': gender,
      'isPregnant': isPregnant,
      'healthIssues': healthIssues,
      'allergies': allergies,
      'foodPreference': foodPreference,
      'familymembers': familymembers,
    };
  }
}
  