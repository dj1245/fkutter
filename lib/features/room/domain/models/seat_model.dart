class Seat {
  bool occupied;
  bool locked;
  String userName;

  Seat({
    required this.occupied,
    required this.locked,
    required this.userName,
  });

  // 🔥 Firebase ready (future use)
  Map<String, dynamic> toMap() {
    return {
      "occupied": occupied,
      "locked": locked,
      "userName": userName,
    };
  }

  factory Seat.fromMap(Map<String, dynamic> map) {
    return Seat(
      occupied: map["occupied"] ?? false,
      locked: map["locked"] ?? false,
      userName: map["userName"] ?? "",
    );
  }
}