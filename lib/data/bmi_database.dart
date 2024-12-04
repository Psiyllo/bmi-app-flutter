import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:path/path.dart';

class BMIDatabase {
  static final BMIDatabase instance = BMIDatabase._init();
  static Database? _database;

  BMIDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('bmi_results.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    try {
      if (isWeb) {
        databaseFactory = databaseFactoryFfiWeb;
      } else {
        sqfliteFfiInit();
        databaseFactory = databaseFactoryFfi;
      }

      final path = filePath;
      return await databaseFactory.openDatabase(
        path,
        options: OpenDatabaseOptions(
          version: 3, // Versão atualizada para refletir a mudança no banco de dados
          onCreate: _createDB,
          onUpgrade: _onUpgrade, // Função de upgrade
        ),
      );
    } catch (e) {
      print("Erro ao abrir o banco de dados: $e");
      rethrow;
    }
  }

  Future<void> _createDB(Database db, int version) async {
    try {
      await db.execute(''' 
        CREATE TABLE bmi_results (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          bmi DOUBLE NOT NULL,
          category TEXT NOT NULL,
          date TEXT NOT NULL,
          age INTEGER NOT NULL, 
          weight DOUBLE NOT NULL, 
          height DOUBLE NOT NULL,  -- Nova coluna para altura
          gender TEXT NOT NULL     
        )
      ''');
      print("Tabela criada com sucesso!");
    } catch (e) {
      print("Erro ao criar a tabela: $e");
      rethrow;
    }
  }

  // Função de upgrade
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 3) {
      await db.execute('''
        ALTER TABLE bmi_results ADD COLUMN height DOUBLE NOT NULL DEFAULT 0.0;
      ''');
      print("Banco de dados atualizado para a versão $newVersion");
    }
  }

  // Função de salvar o resultado
  Future<int> saveResult(double bmi, String category, int age, double weight, double height, String gender) async {
    final db = await instance.database;
    final date = DateTime.now().toIso8601String();

    try {
      print("Salvando o resultado: $bmi, $category, $date, $age, $weight, $height, $gender");
      return await db.insert(
        'bmi_results',
        {
          'bmi': bmi,
          'category': category,
          'date': date,
          'age': age,
          'weight': weight,
          'height': height,  // Salvando altura no banco
          'gender': gender,
        },
      );
    } catch (e) {
      print('Erro ao salvar o resultado: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getResults() async {
    final db = await instance.database;

    try {
      print("Consultando resultados");
      return await db.query('bmi_results', orderBy: 'date DESC');
    } catch (e) {
      print('Erro ao recuperar os resultados: $e');
      rethrow;
    }
  }

  Future<void> close() async {
    final db = await instance.database;
    await db.close();
  }

  bool get isWeb => identical(0, 0.0);
}
