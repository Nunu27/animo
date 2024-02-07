class Identifier {
  final String id;
  final String slug;

  Identifier({required this.id, required this.slug});

  Identifier copyWith({
    String? id,
    String? slug,
  }) {
    return Identifier(
      id: id ?? this.id,
      slug: slug ?? this.slug,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'slug': slug,
    };
  }

  factory Identifier.fromMap(Map<String, dynamic> map) {
    return Identifier(
      id: map['id'] as String,
      slug: map['slug'] as String,
    );
  }

  @override
  String toString() => 'Identifier(id: $id, slug: $slug)';

  @override
  bool operator ==(covariant Identifier other) {
    if (identical(this, other)) return true;

    return other.id == id && other.slug == slug;
  }

  @override
  int get hashCode => id.hashCode ^ slug.hashCode;
}
