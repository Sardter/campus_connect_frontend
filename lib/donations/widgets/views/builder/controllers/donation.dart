import 'package:campus_connect_frontend/donations/donations.dart';
import 'package:campus_connect_frontend/subjects/models/subject.dart';
import 'package:campus_connect_frontend/users/models/user.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class CreateDonationController extends BuilderPublisher<Donation> {
  final CreateDonationDescriptionController descriptionController;
  final BuilderMediaController<ImageData> mediaController;
  @override
  final BuilderWarningsController warningsController;
  @override
  final ModelService<Donation> modelService;
  @override
  final ItemParameters? itemParameters;
  @override
  final bool isUpdating;

  factory CreateDonationController.create() {
    final warningsController = BuilderWarningsController();
    return CreateDonationController(
        descriptionController: CreateDonationDescriptionController(
            warningsController: warningsController),
        mediaController: BuilderMediaController(),
        warningsController: warningsController,
        modelService: ServiceFactory.donationService,
        itemParameters: null,
        isUpdating: false);
  }

  factory CreateDonationController.update({required Donation donation}) {
    final warningsController = BuilderWarningsController();
    return CreateDonationController(
        descriptionController: CreateDonationDescriptionController(
            initialDescription: donation.description,
            initialCurrentValue: donation.currentValue,
            initialTargetValue: donation.targetValue,
            initialTitle: donation.title,
            warningsController: warningsController),
        mediaController: BuilderMediaController(intialMedia: donation.media),
        warningsController: warningsController,
        modelService: ServiceFactory.donationService,
        itemParameters: ItemParameters(id: donation.id),
        isUpdating: true);
  }

  CreateDonationController(
      {required this.descriptionController,
      required this.mediaController,
      required this.warningsController,
      required this.modelService,
      required this.itemParameters,
      required this.isUpdating});

  Donation get donation => Donation(
      id: -1,
      allowedActions: null,
      author: const User(id: -1, email: "null"),
      subject: Subject(id:descriptionController.subjectController.text),
      description: descriptionController.data!.description,
      currentValue: descriptionController.data!.currentValue,
      targetValue: descriptionController.data!.targetValue,
      isFavorited: false,
          favoriteCount: 5,
      title: descriptionController.data!.title,
      media: mediaController.data ?? []);

  @override
  Donation? get data => isValid ? donation : null;

  @override
  List<String> get errorMesseges => [
        ...descriptionController.errorMesseges,
        ...mediaController.errorMesseges
      ];

  @override
  List<MediaData?> get media => mediaController.selectedMedia;
}
