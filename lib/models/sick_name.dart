class Sick {
  int? id;
  String? question;
  String? answer;

  Sick(this.question, this.answer, this.id);



  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      "question": question,
      "answer": answer,

    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  Sick.fromMap(Map<String, Object?> map) {
    id = (map["id"] as int?)!;
    question = (map["question"] as String?)!;
    answer = (map["answer"] as String?)!;

  }

  Sick.fromJson(Map<String, dynamic> json){
    question = json["question"];
    answer = json["answer"];
  }
}