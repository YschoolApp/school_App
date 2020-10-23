class Class {
  String id;
  String name;
  String docId;

  Class({
    this.id,
    this.name,
    this.docId,
  });

  factory Class.fromMap(Map map,String docID) {
    return new Class(
      id: map['id'],
      name: map['name'],
      docId: docID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
    };
  }
}
