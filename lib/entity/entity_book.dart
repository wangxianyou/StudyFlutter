class Book {
  String id;
  String name;
  String author;

  Map<String, dynamic> toBook() {
    var map = {
      "_id": id,
      "name": name,
      "author": author,
    };
    return map;
  }

  Book.from(Map<String, dynamic> map) {
    id = map["_id"];
    name = map["name"];
    author = map["author"];
  }

  @override
  String toString() {
    return "Book{_id:$id,name:$name,author:$author}";
  }
}
