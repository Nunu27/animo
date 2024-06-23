import 'package:animo/domain/entities/filter/filter.dart';

class FilterInput extends Filter {
  final String? text;

  FilterInput(super.label, super.key, {this.text});
}
