import 'package:my_cover_ai_test/src/feature/inspection_process/views/widget/style_text_egment.dart';
import 'package:my_cover_ai_test/src/shared/utils/app_assets.dart';
import 'package:my_cover_ai_test/src/shared/utils/enum.dart';

class InspectionModel {
  final List<StyledTextSegment> instructionSegments;
  final String image;
  final String viewText;

  InspectionModel(
      {required this.instructionSegments,
      required this.image,
      required this.viewText});
}

final List<InspectionModel> inspectionSteps = [
  InspectionModel(
    viewText: '',
    instructionSegments: [
      StyledTextSegment(
          text: "Park your Vehicle in a ", type: StyledTextType.normal),
      StyledTextSegment(text: "well-lit, shaded, ", type: StyledTextType.bold),
      StyledTextSegment(text: "and ", type: StyledTextType.normal),
      StyledTextSegment(text: "spacious area ", type: StyledTextType.bold),
      StyledTextSegment(
          text: "ensuring there are ", type: StyledTextType.normal),
      StyledTextSegment(text: "no obstructions.", type: StyledTextType.bold),
    ],
    image: AppAssets.careView,
  ),
  InspectionModel(
      viewText: 'Front View',
      instructionSegments: [
        StyledTextSegment(
            text: "Take picture of your", type: StyledTextType.normal),
        StyledTextSegment(text: " Vehicle's ", type: StyledTextType.bold),
        StyledTextSegment(
          text: "front view",
          type: StyledTextType.highlightedGreen,
        ),
        StyledTextSegment(
            text: ", ensuring it fills about ", type: StyledTextType.normal),
        StyledTextSegment(text: "80%", type: StyledTextType.highlightedGreen),
        StyledTextSegment(
            text: " of your camera screen.", type: StyledTextType.normal),
      ],
      image: AppAssets.frontView),
  InspectionModel(
      viewText: 'Left View ( Driver side )',
      instructionSegments: [
        StyledTextSegment(
            text: "Take picture of your", type: StyledTextType.normal),
        StyledTextSegment(text: " Vehicle's ", type: StyledTextType.bold),
        StyledTextSegment(
          text: "Left view",
          type: StyledTextType.highlightedGreen,
        ),
        StyledTextSegment(
            text: ", ensuring it fills about ", type: StyledTextType.normal),
        StyledTextSegment(text: "80%", type: StyledTextType.highlightedGreen),
        StyledTextSegment(
            text: " of your camera screen.", type: StyledTextType.normal),
      ],
      image: AppAssets.leftView),
  InspectionModel(
      viewText: 'Back View',
      instructionSegments: [
        StyledTextSegment(
            text: "Take picture of your", type: StyledTextType.normal),
        StyledTextSegment(text: " Vehicle's ", type: StyledTextType.bold),
        StyledTextSegment(
          text: "Back view",
          type: StyledTextType.highlightedGreen,
        ),
        StyledTextSegment(
            text: ", ensuring it fills about ", type: StyledTextType.normal),
        StyledTextSegment(text: "80%", type: StyledTextType.highlightedGreen),
        StyledTextSegment(
            text: " of your camera screen.", type: StyledTextType.normal),
      ],
      image: AppAssets.backView),
  InspectionModel(
      viewText: 'Right View',
      instructionSegments: [
        StyledTextSegment(
            text: "Take picture of your", type: StyledTextType.normal),
        StyledTextSegment(text: " Vehicle's ", type: StyledTextType.bold),
        StyledTextSegment(
          text: "Right view",
          type: StyledTextType.highlightedGreen,
        ),
        StyledTextSegment(
            text: ", ensuring it fills about ", type: StyledTextType.normal),
        StyledTextSegment(text: "80%", type: StyledTextType.highlightedGreen),
        StyledTextSegment(
            text: " of your camera screen.", type: StyledTextType.normal),
      ],
      image: AppAssets.rightView),
  InspectionModel(
      viewText: 'Chassis number',
      instructionSegments: [
        StyledTextSegment(
            text: "Take picture of your", type: StyledTextType.normal),
        StyledTextSegment(text: " Vehicle's ", type: StyledTextType.bold),
        StyledTextSegment(
          text: "Chassis no.",
          type: StyledTextType.highlightedGreen,
        ),
      ],
      image: AppAssets.chasis),
  InspectionModel(
      viewText: 'Vehicle Dashboard',
      instructionSegments: [
        StyledTextSegment(text: "Take picture of your Vehicle's "),
        StyledTextSegment(
            text: "Dashboard", type: StyledTextType.highlightedBlue),
        StyledTextSegment(text: ", ensuring it fills about "),
        StyledTextSegment(text: "80%", type: StyledTextType.highlightedGreen),
        StyledTextSegment(text: " of your camera screen."),
      ],
      image: AppAssets.vehicleDashboard),
  InspectionModel(
      viewText: 'Vehicle Backview',
      instructionSegments: [
        StyledTextSegment(text: "Take picture of your Vehicle's "),
        StyledTextSegment(
            text: "Interior Back view", type: StyledTextType.highlightedBlue),
        StyledTextSegment(text: ", ensuring it fills about "),
        StyledTextSegment(text: "80%", type: StyledTextType.highlightedGreen),
        StyledTextSegment(text: " of your camera screen."),
      ],
      image: AppAssets.vehicleBackView),
];
