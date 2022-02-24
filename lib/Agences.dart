class Agence {
  final int IDAgence;
  final String NomAgence;

  const Agence({required this.IDAgence, required this.NomAgence});

  factory Agence.fromJson(Map<String, dynamic> json) {
    return Agence(IDAgence: json['idAgence'], NomAgence: json['nomAgence']);
  }
}
