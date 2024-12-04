class BMIModel {
  final double height;
  final double weight;
  final int age;
  final String gender;

  BMIModel({
    required this.height,
    required this.weight,
    required this.age,
    required this.gender,
  });

  double calculateBMI() {
    return weight / ((height / 100) * (height / 100));
  }

  String getBMICategory() {
    final bmi = calculateBMI();
    if (bmi < 18.5) return 'UNDERWEIGHT';
    if (bmi < 24.9) return 'NORMAL BMI';
    if (bmi < 29.9) return 'OVERWEIGHT';
    return 'OBESE';
  }
}