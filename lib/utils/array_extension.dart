extension ArrayExtension on List {
  filterRooms() {
    return this.where((element) => element.type != 'd').toList();
  }
}