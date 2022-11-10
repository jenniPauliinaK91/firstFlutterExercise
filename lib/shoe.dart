class Shoe {
  final String name; //nimi pakollinen
  final String date; // käyttöönottopäivä
  int kms; //kengällä juostut kilometrit -- edit. olisi pitänyt olla double.
  int? id;

  Shoe({required this.name, required this.date, this.kms = 0, this.id});

  factory Shoe.fromMap(Map<String, dynamic> json) => Shoe(
      name: json['name'], date: json['date'], kms: json['kms'], id: json['id']);

  Map<String, dynamic> toMap() {
    return {'name': name, 'date': date, 'kms': kms, 'id': id};
  }
}
