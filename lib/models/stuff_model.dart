class StuffModel {
  int id;
  String description;
  String contactName;
  String phone;
  String photoPath;
  String date;

  StuffModel({
    this.id,
    this.description,
    this.contactName,
    this.phone,
    this.photoPath,
    this.date,
  });

  bool get hasPhoto => photoPath != null && photoPath.isNotEmpty;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'description': description,
      'contactName': contactName,
      'phone': phone,
      'photoPath': photoPath,
      'date': date,
    };

    if (id != null) data['id'] = id;
    return data;
  }

  factory StuffModel.fromMap(Map<String, dynamic> map) {
    return StuffModel(
      id: map['id'],
      description: map['description'],
      contactName: map['contactName'],
      phone: map['phone'],
      photoPath: map['photoPath'],
      date: map['date'],
    );
  }
}
