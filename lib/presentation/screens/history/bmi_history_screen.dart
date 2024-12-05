import 'package:flutter/material.dart';
import '../../../data/bmi_database.dart'; // Importação do banco de dados
import '../../../core/theme/app_colors.dart'; // Importando AppColors para utilizar o primary

class BMIHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI History'),
        backgroundColor: AppColors.primary, // Usando o AppColors.primary para o fundo da AppBar
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>( // Recuperando dados do banco
        future: BMIDatabase.instance.getResults(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No results saved yet.'));
          } else {
            final results = snapshot.data!;
            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final result = results[index];
                
                // Formatando a data para visualização mais amigável
                final date = DateTime.tryParse(result['date'])?.toLocal() ?? DateTime.now();
                final formattedDate = '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
                
                // Formatando o valor do BMI com 2 casas decimais
                final bmi = double.tryParse(result['bmi'].toString())?.toStringAsFixed(2) ?? 'N/A';

                // Adicionando informações de idade, peso, altura e gênero
                final age = result['age'] ?? 'N/A';
                final weight = result['weight'] ?? 'N/A';
                final height = result['height'] ?? 'N/A';
                final gender = result['gender'] ?? 'N/A';

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Cantos arredondados
                  ),
                  elevation: 5, // Adicionando sombra para efeito de destaque
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Ícone para melhorar a visualização
                        Icon(
                          Icons.fitness_center,
                          color: AppColors.primary,
                          size: 40,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Exibindo o BMI e a categoria
                              Text(
                                'BMI: $bmi',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Category: ${result['category']}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Exibindo a idade, peso, altura e gênero
                              Text(
                                'Age: $age, Weight: $weight kg, Height: $height cm, Gender: $gender',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Exibindo a data de forma mais amigável
                              Text(
                                'Date: $formattedDate',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
