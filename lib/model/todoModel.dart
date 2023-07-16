// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers

class TodoModel {
  String? title;
  String? desc;
  String? id;

  TodoModel({this.title, this.desc, this.id});

  TodoModel.fromJson(Map<String, dynamic> json) {
    if(json["title"] is String) {
      title = json["title"];
    }
    if(json["desc"] is String) {
      desc = json["desc"];
    }
    if(json["id"] is String) {
      id = json["id"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = title;
    _data["desc"] = desc;
    _data["id"] = id;
    return _data;
  }
}