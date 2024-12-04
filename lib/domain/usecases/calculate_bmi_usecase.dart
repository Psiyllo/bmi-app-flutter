import '../../data/models/bmi_model.dart';

class CalculateBMIUseCase {
  double execute(BMIModel model) {
    return model.calculateBMI();
  }

  String getBMICategory(BMIModel model) {
    return model.getBMICategory();
  }
}