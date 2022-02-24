class Region {
  final int IDRegion;
  final String NomRegion;

  const Region({
    required this.IDRegion,
    required this.NomRegion,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(IDRegion: json['idRegion'], NomRegion: json['nomRegion']);
  }
}
