import 'package:campus_connect_frontend/lost_and_founds/lost_and_founds.dart';
import 'package:campus_connect_frontend/users/models/user.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class CreateLostAndFoundController extends BuilderPublisher<LostAndFound> {
  final CreateLostAndFoundDescriptionController descriptionController;
  final BuilderMediaController<ImageData> mediaController;
  final BuilderDateController dateController;
  @override
  final BuilderWarningsController warningsController;
  @override
  final ModelService<LostAndFound> modelService;
  @override
  final ItemParameters? itemParameters;
  @override
  final bool isUpdating;

  factory CreateLostAndFoundController.create() {
    final warningsController = BuilderWarningsController();
    return CreateLostAndFoundController(
        descriptionController: CreateLostAndFoundDescriptionController(
            warningsController: warningsController),
        mediaController: BuilderMediaController(),
        warningsController: warningsController,
        dateController: BuilderDateController(oneDateMode: true),
        modelService: ServiceFactory.lostAndFoundService,
        itemParameters: null,
        isUpdating: false);
  }

  factory CreateLostAndFoundController.update(
      {required LostAndFound lostAndFound}) {
    final warningsController = BuilderWarningsController();
    return CreateLostAndFoundController(
        descriptionController: CreateLostAndFoundDescriptionController(
            initialDescription: lostAndFound.description,
            initialItem: lostAndFound.item,
            initialLocation: lostAndFound.location,
            initialTitle: lostAndFound.title,
            warningsController: warningsController),
        mediaController:
            BuilderMediaController(intialMedia: lostAndFound.media),
        warningsController: warningsController,
        dateController: BuilderDateController(
            initialStartDate: lostAndFound.date, oneDateMode: true),
        modelService: ServiceFactory.lostAndFoundService,
        itemParameters: ItemParameters(id: lostAndFound.id),
        isUpdating: true);
  }

  CreateLostAndFoundController(
      {required this.descriptionController,
      required this.mediaController,
      required this.warningsController,
      required this.dateController,
      required this.modelService,
      required this.itemParameters,
      required this.isUpdating});

  LostAndFound get lostAndFound => LostAndFound(
      id: -1,
      allowedActions: null,
      author: const User(id: -1, email: "null"),
      description: descriptionController.data!.description,
      item: descriptionController.data!.item,
      title: descriptionController.data!.title,
      isFavorited: false,
          favoriteCount: 5,
      date: dateController.startDateController.date,
      location: descriptionController.locationController.text,
      media: mediaController.data ?? []);

  @override
  LostAndFound? get data => isValid ? lostAndFound : null;

  @override
  List<String> get errorMesseges => [
        ...descriptionController.errorMesseges,
        ...mediaController.errorMesseges,
        //...dateController.errorMesseges
      ];

  @override
  List<MediaData?> get media => mediaController.selectedMedia;
}
