class Hotspot {
  final String id;
  final String name;

  Hotspot({required this.id, required this.name});

  factory Hotspot.fromMap(Map<String, dynamic> map) {
    return Hotspot(
      id: map['hotspotId'],
      name: map['name'],
    );
  }
}
