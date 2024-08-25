import 'package:campus_connect_frontend/second_hands/second_hands.dart';
import 'package:campus_connect_frontend/users/models/user.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class CreateSecondHandController extends BuilderPublisher<SecondHand> {
  final CreateSecondHandDescriptionController descriptionController;
  final BuilderMediaController<ImageData> mediaController;
  @override
  final BuilderWarningsController warningsController;
  @override
  final ModelService<SecondHand> modelService;
  @override
  final ItemParameters? itemParameters;
  @override
  final bool isUpdating;

  factory CreateSecondHandController.create() {
    final warningsController = BuilderWarningsController();
    return CreateSecondHandController(
        descriptionController: CreateSecondHandDescriptionController(
            warningsController: warningsController),
        mediaController: BuilderMediaController(),
        warningsController: warningsController,
        modelService: ServiceFactory.secondHandService,
        itemParameters: null,
        isUpdating: false);
  }

  factory CreateSecondHandController.update({required SecondHand secondHand}) {
    final warningsController = BuilderWarningsController();
    return CreateSecondHandController(
        descriptionController: CreateSecondHandDescriptionController(
            initialCourse: secondHand.course,
            initialDescription: secondHand.description,
            initialItem: secondHand.item,
            initialPrice: secondHand.price,
            initialTitle: secondHand.title,
            warningsController: warningsController),
        mediaController: BuilderMediaController(intialMedia: secondHand.media),
        warningsController: warningsController,
        modelService: ServiceFactory.secondHandService,
        itemParameters: ItemParameters(id: secondHand.id),
        isUpdating: true);
  }

  CreateSecondHandController(
      {required this.descriptionController,
      required this.mediaController,
      required this.warningsController,
      required this.modelService,
      required this.itemParameters,
      required this.isUpdating});

  SecondHand get secondHand => SecondHand(
      id: -1,
      allowedActions: null,
      author: const User(id: -1, email: "null"),
      description: descriptionController.data!.description,
      course: descriptionController.data!.course,
      price: descriptionController.data!.price,
      item: descriptionController.data!.item,
      title: descriptionController.data!.title,
      isFavorited: false,
      favoriteCount: 5,
      media: mediaController.data ?? []);

  @override
  SecondHand? get data => isValid ? secondHand : null;

  @override
  List<String> get errorMesseges => [
        ...descriptionController.errorMesseges,
        ...mediaController.errorMesseges
      ];

  @override
  List<MediaData?> get media => mediaController.selectedMedia;
}
