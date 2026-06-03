class Peserta {
  int? id;
  String nama;
  String email;
  String password;
  String? nomorHp;

  Peserta({
    this.id,
    required this.nama,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'nama': nama, 'email': email, 'password': password};
  }

  factory Peserta.fromMap(Map<String, dynamic> map) {
    return Peserta(
      id: map['id'],
      nama: map['nama'],
      email: map['email'],
      password: map['password'],
    );
  }
}
