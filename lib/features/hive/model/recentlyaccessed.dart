import 'package:hive/hive.dart';

part 'recentlyaccessed.g.dart';

@HiveType(typeId: 0)
class RecentlyAccessed extends HiveObject {
  @HiveField(0)
  String notesid;

  @HiveField(1)
  String accessed;


  RecentlyAccessed(this.notesid, this.accessed);
}
