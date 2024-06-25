class PatientModel {
  String name;
  String address;
  double height;
  int age;
  String number;

  PatientModel({required this.name, required this.address, required this.height, required this.age, required this.number});
}

List<PatientModel> patients = [
  PatientModel(name: 'Sourav Barman', address: 'Joypurhat', height: 5.8, age: 25, number: '123-456-7890'),
  PatientModel(name: 'Rana', address: 'Khulna', height: 5.5, age: 30, number: '987-654-3210'),
  PatientModel(name: 'Mamun', address: '789 Oak St', height: 6.1, age: 28, number: '555-666-7777'),
];
