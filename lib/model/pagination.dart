class Pagination {
  int totalItems;
  Null nextPage;

  Pagination({this.totalItems, this.nextPage});

  Pagination.fromJson(Map<String, dynamic> json)
      : totalItems = json["total_items"],
        nextPage = json["next_page"];
}