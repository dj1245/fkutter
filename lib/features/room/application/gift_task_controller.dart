import '../domain/models/gift_task.dart';

class GiftTaskController {
  final List<GiftTask> tasks = [
    GiftTask(
      target: 250,
      iconPath: 'assets/images/gift_250.png',
      rewardType: 'tier1',
    ),
    GiftTask(
      target: 150,
      iconPath: 'assets/images/gift_150.png',
      rewardType: 'tier2',
    ),
    GiftTask(
      target: 100,
      iconPath: 'assets/images/gift_100.png',
      rewardType: 'tier3',
    ),
  ];

  int currentTaskIndex = 0;
  int currentProgress = 0;

  GiftTask get currentTask => tasks[currentTaskIndex];

  String get progressText => "$currentProgress / ${currentTask.target}";

  void addGift(int amount, {Function()? onComplete, Function()? onFinal}) {
    currentProgress += amount;
    if (currentTaskIndex >= tasks.length) {
      return;
    }

    if (currentProgress >= currentTask.target) {
      currentProgress = 0;
      currentTaskIndex++;

      if (currentTaskIndex >= tasks.length) {
        currentTaskIndex = tasks.length - 1;
        onFinal?.call();
        return;
      }
      onComplete?.call();
    }
  }
}