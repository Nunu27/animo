class SelectOption {
  final String text;
  final String? key;
  final String? value;

  SelectOption(this.text, this.value, {this.key});

  SelectOption copyWith({
    String? text,
    String? key,
    String? value,
  }) {
    return SelectOption(
      text ?? this.text,
      value ?? this.value,
      key: key ?? this.key,
    );
  }

  factory SelectOption.fromMap(Map<String, dynamic> map) {
    return SelectOption(
      map['text'] as String,
      map['value'] != null ? map['value'] as String : null,
      key: map['key'] != null ? map['key'] as String : null,
    );
  }

  @override
  String toString() => 'SelectOption(text: $text, key: $key, value: $value)';

  @override
  bool operator ==(covariant SelectOption other) {
    if (identical(this, other)) return true;

    return other.text == text && other.key == key && other.value == value;
  }

  @override
  int get hashCode => text.hashCode ^ key.hashCode ^ value.hashCode;
}
