class BMIModel {
  final double height;
  final double weight;
  final int age;
  final String gender;

  double? _bmi;
  String? _category;

  BMIModel({
    required this.height,
    required this.weight,
    required this.age,
    required this.gender,
  });

  // Método para calcular o IMC
  double calculateBMI() {
    if (_bmi == null) {
      _bmi = weight / ((height / 100) * (height / 100));
    }
    return _bmi!;
  }

  // Método para calcular a categoria do IMC
  String getBMICategory() {
    if (_category == null) {
      final bmi = calculateBMI();
      if (bmi < 18.5) {
        _category = 'UNDERWEIGHT';
      } else if (bmi < 24.9) {
        _category = 'NORMAL BMI';
      } else if (bmi < 29.9) {
        _category = 'OVERWEIGHT';
      } else {
        _category = 'OBESE';
      }
    }
    return _category!;
  }

  // Método para obter o IMC com precisão de 2 casas decimais
  String getFormattedBMI() {
    return calculateBMI().toStringAsFixed(2);
  }

  // Representação do modelo como String (opcional)
  @override
  String toString() {
    return 'BMI Model: Height = $height, Weight = $weight, Age = $age, Gender = $gender, BMI = ${getFormattedBMI()}, Category = $getBMICategory()';
  }
}
