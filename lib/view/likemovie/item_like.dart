import 'dart:convert' show json;

class ItemLike {
  String? name;
  dynamic value;
  ItemLike.fromParams({required this.name, this.value});

  // factory ItemLike(jsonStr) => jsonStr == null
  //     ? null
  //     : jsonStr is String
  //         ? new ItemLike.fromJson(json.decode(jsonStr))
  //         : new ItemLike.fromJson(jsonStr);

  ItemLike.fromJson(jsonRes) {
    name = jsonRes['name'];
    value = jsonRes['value'];
  }
  @override
  String toString() {
    return '{"name": "$name","value": ${value != null ? '${json.encode(value)}' : 'null'}}';
  }
}
