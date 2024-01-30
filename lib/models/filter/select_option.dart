class SelectOption {
  final String text;
  final String? key;
  final String? value;

  SelectOption(this.text, this.value, {this.key});

  @override
  bool operator ==(covariant SelectOption other) {
    if (identical(this, other)) return true;

    return other.text == text && other.value == value;
  }

  @override
  int get hashCode => text.hashCode ^ value.hashCode;
}
