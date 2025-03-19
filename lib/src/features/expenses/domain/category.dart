import 'package:hive/hive.dart';

part 'category.g.dart';

@HiveType(typeId: 2)
class Category {
  @HiveField(0)
  String name;

  // UI related
  @HiveField(1)
  String displayColor;

  Category({required this.name, this.displayColor = "#ffffff"});

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Category &&
            runtimeType == other.runtimeType &&
            hashCode == other.hashCode;
  }

  @override
  int get hashCode => Object.hash(name.hashCode, displayColor.hashCode);
}
