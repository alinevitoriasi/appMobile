class Category {
    int id;
    String name;
    String tags;
    DateTime createdAt;
    DateTime updatedAt;
    String image;

    Category({
        this.id,
        this.name,
        this.tags,
        this.createdAt,
        this.updatedAt,
        this.image,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        tags: json["tags"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        image: json["image"],
    );
}