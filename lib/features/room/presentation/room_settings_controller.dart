import 'package:flutter/material.dart';

class RoomSettingsController extends ChangeNotifier {

  // 🎨 Appearance
  String? coverPhoto;
  String? background;

  // 📢 Communication
  String greeting = "";
  String announcement = "";

  // ⚙️ Room Control
  String roomMode = "Public"; // Public / Private / Paid

  String whoCanJoin = "Everyone"; // Everyone / Followers / Invite
  String whoCanBeSeated = "Everyone";

  // 👑 Roles (simple lists for now)
  List<String> owners = [];
  List<String> coOwners = [];
  List<String> admins = [];

  // 🚫 Block List
  List<String> blockedUsers = [];

  // ===================== FUNCTIONS =====================

  void setCoverPhoto(String path) {
    coverPhoto = path;
    notifyListeners();
  }

  void setBackground(String bg) {
    background = bg;
    notifyListeners();
  }

  void setGreeting(String text) {
    greeting = text;
    notifyListeners();
  }

  void setAnnouncement(String text) {
    announcement = text;
    notifyListeners();
  }

  void setRoomMode(String mode) {
    roomMode = mode;
    notifyListeners();
  }

  void setWhoCanJoin(String value) {
    whoCanJoin = value;
    notifyListeners();
  }

  void setWhoCanBeSeated(String value) {
    whoCanBeSeated = value;
    notifyListeners();
  }

  void addBlock(String userId) {
    blockedUsers.add(userId);
    notifyListeners();
  }

  void removeBlock(String userId) {
    blockedUsers.remove(userId);
    notifyListeners();
  }
}