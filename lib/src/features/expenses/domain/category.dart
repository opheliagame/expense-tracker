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
}
