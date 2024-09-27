// db_helper.dart

import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../models/models.dart';

class DatabaseHelper {
  // Singleton pattern
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the database
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'patient_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Create the patient table
  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE patient(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        address TEXT NOT NULL,
        height REAL NOT NULL,
        age INTEGER NOT NULL,
        number TEXT NOT NULL
      )
    ''');
  }

  // Insert a new patient
  Future<int> insertPatient(Patient patient) async {
    final db = await database;
    return await db.insert(
      'patient',
      patient.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Retrieve all patients
  Future<List<Patient>> getPatients() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('patient');

    return List.generate(maps.length, (i) {
      return Patient.fromMap(maps[i]);
    });
  }

  // Update a patient
  Future<int> updatePatient(Patient patient) async {
    final db = await database;
    return await db.update(
      'patient',
      patient.toMap(),
      where: 'id = ?',
      whereArgs: [patient.id],
    );
  }

  // Delete a patient
  Future<int> deletePatient(int id) async {
    final db = await database;
    return await db.delete(
      'patient',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
