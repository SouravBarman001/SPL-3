// models.dart

class Patient {
  int? id; // SQLite primary key
  String name;
  String address;
  double height;
  int age;
  String number;

  Patient({
    this.id,
    required this.name,
    required this.address,
    required this.height,
    required this.age,
    required this.number,
  });

  // Convert a Patient into a Map.
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'address': address,
      'height': height,
      'age': age,
      'number': number,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  // Extract a Patient object from a Map.
  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      height: map['height'],
      age: map['age'],
      number: map['number'],
    );
  }
}
