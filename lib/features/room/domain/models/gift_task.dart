class GiftTask {
  final int target;        // e.g. 250, 150, 100
  final String iconPath;   // PNG image path
  final String rewardType; // tier1, tier2, tier3 etc.

  const GiftTask({
    required this.target,
    required this.iconPath,
    required this.rewardType,
  });
}