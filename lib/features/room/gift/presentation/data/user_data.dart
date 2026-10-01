class UsersData {
  static final List<Map<String, dynamic>> users = List.generate(
    6,
        (i) => {
      "name": "Seat ${i + 1}",
      "img": "https://i.pravatar.cc/150?img=${i + 1}",
    },
  );
}