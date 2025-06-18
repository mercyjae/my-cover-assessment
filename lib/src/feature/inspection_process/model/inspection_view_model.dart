// shared_data.dart
import 'package:my_cover_ai_test/src/shared/utils/app_assets.dart';

class InspectionViewModel {
  final String viewStatus;
  final String viewTitle;
  final String instruction;
  final String overlayAsset;

  const InspectionViewModel({
    required this.viewStatus,
    required this.viewTitle,
    required this.instruction,
    required this.overlayAsset,
  });
}

final List<InspectionViewModel> inspectionView = [
  InspectionViewModel(
      viewStatus: 'Left Side',
      viewTitle: 'left',
      instruction: 'Take picture of your vehicle\'s left side view.',
      overlayAsset: AppAssets.newLeftView),
  InspectionViewModel(
      viewStatus: 'Right Side',
      viewTitle: 'right',
      instruction: 'Take picture of your vehicle\'s right side view.',
      overlayAsset: AppAssets.newRightView),
  InspectionViewModel(
      viewStatus: 'Front Side',
      viewTitle: 'front',
      instruction: 'Take picture of your vehicle\'s front view.',
      overlayAsset: AppAssets.newFrontView),
];
