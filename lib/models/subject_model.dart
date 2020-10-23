class Subject {
  String id;
  String name;
  String docId;

  Subject({this.name, this.id, this.docId});

  factory Subject.fromMap(Map map,String docID) {
    return new Subject(
      id: map['id'] as String,
      name: map['subj_name'] as String,
      docId: docID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subj_name': name,
    };
  }
}
