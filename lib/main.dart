import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart'; // Tema do app
import 'presentation/screens/home/onboarding_screen.dart'; // Tela inicial de onboarding
import 'data/bmi_database.dart'; // Banco de dados para os resultados de BMI
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

void main() {
  // Detecta se o app está rodando no navegador
  if (isWeb) {
    // Configura o suporte para Web
    databaseFactory = databaseFactoryFfiWeb;
  } else {
    // Configura o suporte para desktop e dispositivos móveis
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const MyApp());
}

bool get isWeb => identical(0, 0.0); // Verifica se o ambiente é Web

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI App',
      theme: AppTheme.light, // Tema do app
      home: const OnboardingScreen(), // Tela de onboarding ou inicial
      routes: {
        '/history': (context) =>
            const BmiResultsScreen(), // Rota para a tela de resultados
      },
    );
  }
}

class BmiResultsScreen extends StatefulWidget {
  const BmiResultsScreen({super.key});

  @override
  _BmiResultsScreenState createState() => _BmiResultsScreenState();
}

class _BmiResultsScreenState extends State<BmiResultsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados BMI'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // Navega para a tela de histórico
              Navigator.pushNamed(context, '/history');
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        // Chama o banco de dados para recuperar resultados
        future: BMIDatabase.instance.getResults(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Mostra o carregando enquanto espera
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum resultado encontrado.'));
          } else {
            final results = snapshot.data!;
            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final result = results[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text('BMI: ${result['bmi']}'),
                    subtitle: Text('Categoria: ${result['category']}'),
                    trailing: Text(result['date']),
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
